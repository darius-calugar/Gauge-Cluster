import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:orbital/orbital.dart';

/// Orbital equivalent of [Rect].
@immutable
class OrbitalSector {
  const OrbitalSector.fromSEIO(this.start, this.end, this.inner, this.outer);

  const OrbitalSector.fromSIST(
    this.start,
    this.inner,
    double sweep,
    double thickness,
  ) : end = start + sweep,
      outer = inner + thickness;

  static const OrbitalSector zero = OrbitalSector.fromSEIO(0, 0, 0, 0);

  final double start;
  final double end;
  final double inner;
  final double outer;

  double get sweep => end - start;
  double get thickness => outer - inner;
  double get middleAngle => (start + end) / 2;
  double get middleRadius => (inner + outer) / 2;

  OrbitalSize get size => OrbitalSize(thickness: thickness, sweepAngle: sweep);

  OrbitalOffset get innerStart => OrbitalOffset(da: start, dr: inner);
  OrbitalOffset get innerCenter => OrbitalOffset(da: middleAngle, dr: inner);
  OrbitalOffset get innerEnd => OrbitalOffset(da: end, dr: inner);

  OrbitalOffset get centerStart => OrbitalOffset(da: start, dr: middleRadius);
  OrbitalOffset get center => OrbitalOffset(da: middleAngle, dr: middleRadius);
  OrbitalOffset get centerEnd => OrbitalOffset(da: end, dr: middleRadius);

  OrbitalOffset get outerStart => OrbitalOffset(da: start, dr: outer);
  OrbitalOffset get outerCenter => OrbitalOffset(da: middleAngle, dr: outer);
  OrbitalOffset get outerEnd => OrbitalOffset(da: end, dr: outer);

  bool get hasNan => start.isNaN || end.isNaN || inner.isNaN || outer.isNaN;

  bool get isInfinite =>
      start.isInfinite ||
      end.isInfinite ||
      inner.isInfinite ||
      outer.isInfinite;

  bool get isFinite => !isInfinite;

  bool get isEmpty => start >= end || inner >= outer;

  OrbitalSector operator +(OrbitalSize size) => OrbitalSector.fromSEIO(
    start,
    end + size.sweepAngle,
    inner,
    outer + size.thickness,
  );

  OrbitalSector operator -(OrbitalSize size) => OrbitalSector.fromSEIO(
    start,
    end - size.sweepAngle,
    inner,
    outer - size.thickness,
  );

  bool contains(OrbitalOffset offset) =>
      offset.da >= start &&
      offset.da <= end &&
      offset.dr >= inner &&
      offset.dr <= outer;

  OrbitalSector inflate(double delta) => OrbitalSector.fromSEIO(
    start - delta,
    end + delta,
    inner - delta,
    outer + delta,
  );

  OrbitalSector deflate(double delta) => inflate(-delta);

  OrbitalSector expandToInclude(OrbitalSector other) => OrbitalSector.fromSEIO(
    math.min(start, other.start),
    math.max(end, other.end),
    math.min(inner, other.inner),
    math.max(outer, other.outer),
  );

  OrbitalSector intersect(OrbitalSector other) => OrbitalSector.fromSEIO(
    math.max(start, other.start),
    math.min(end, other.end),
    math.max(inner, other.inner),
    math.min(outer, other.outer),
  );

  OrbitalSector shift(OrbitalOffset offset) => OrbitalSector.fromSEIO(
    start + offset.da,
    end + offset.da,
    inner + offset.dr,
    outer + offset.dr,
  );

  OrbitalSector translate(double translateAngle, double translateRadius) =>
      OrbitalSector.fromSEIO(
        start + translateAngle,
        end + translateAngle,
        inner + translateRadius,
        outer + translateRadius,
      );

  bool overlaps(OrbitalSector other) {
    if (start >= other.end || other.start >= end) return false;
    if (inner >= other.outer || other.inner >= outer) return false;
    return true;
  }

  Path toPath() {
    final innerRect = Offset(thickness, thickness) & Size.square(inner * 2);
    final outerRect = Offset.zero & Size.square(outer * 2);

    final innerPath =
        sweep == 2 * math.pi ? (Path()..addOval(innerRect)) : Path()
          ..moveTo(innerRect.center.dx, innerRect.center.dy)
          ..arcTo(innerRect, start, sweep, false)
          ..close();
    final outerPath =
        sweep == 2 * math.pi ? (Path()..addOval(outerRect)) : Path()
          ..moveTo(outerRect.center.dx, outerRect.center.dy)
          ..arcTo(outerRect, end, -sweep, false)
          ..close();

    return Path.combine(PathOperation.difference, outerPath, innerPath);
  }

  @override
  bool operator ==(Object other) =>
      other is OrbitalSector &&
      other.start == start &&
      other.end == end &&
      other.inner == inner &&
      other.outer == outer;

  @override
  int get hashCode => Object.hash(start, end, inner, outer);

  @override
  String toString() =>
      'OrbitalSector(start: $start, end: $end, inner: $inner, outer: $outer)';
}
