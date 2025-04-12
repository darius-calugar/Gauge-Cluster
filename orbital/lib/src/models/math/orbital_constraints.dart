import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:orbital/orbital.dart';

@immutable
extension type const OrbitalConstraints._(BoxConstraints raw)
    implements Constraints {
  OrbitalConstraints({
    double minSweepAngle = 0,
    double maxSweepAngle = double.infinity,
    double minThickness = 0,
    double maxThickness = double.infinity,
  }) : raw = BoxConstraints(
         minWidth: minSweepAngle,
         maxWidth: maxSweepAngle,
         minHeight: minThickness,
         maxHeight: maxThickness,
       );

  OrbitalConstraints.tightFor({double? sweepAngle, double? thickness})
    : raw = BoxConstraints.tightFor(width: sweepAngle, height: thickness);

  OrbitalConstraints.tight(OrbitalSize size)
    : raw = BoxConstraints.tight(size.raw);

  OrbitalConstraints.loose(OrbitalSize size)
    : raw = BoxConstraints.loose(size.raw);

  double get minSweepAngle => raw.minWidth;
  double get maxSweepAngle => raw.maxWidth;
  double get minThickness => raw.minHeight;
  double get maxThickness => raw.maxHeight;

  OrbitalSize get smallest =>
      OrbitalSize(thickness: minThickness, sweepAngle: minSweepAngle);

  OrbitalSize get biggest =>
      OrbitalSize(thickness: maxThickness, sweepAngle: maxSweepAngle);

  OrbitalConstraints get flipped => OrbitalConstraints(
    minThickness: minSweepAngle,
    maxThickness: maxSweepAngle,
    minSweepAngle: minThickness,
    maxSweepAngle: maxThickness,
  );

  OrbitalConstraints enforce(OrbitalConstraints constraints) =>
      OrbitalConstraints(
        minThickness: clampDouble(
          minThickness,
          constraints.minThickness,
          constraints.maxThickness,
        ),
        maxThickness: clampDouble(
          maxThickness,
          constraints.minThickness,
          constraints.maxThickness,
        ),
        minSweepAngle: clampDouble(
          minSweepAngle,
          constraints.minSweepAngle,
          constraints.maxSweepAngle,
        ),
        maxSweepAngle: clampDouble(
          maxSweepAngle,
          constraints.minSweepAngle,
          constraints.maxSweepAngle,
        ),
      );

  OrbitalConstraints inflate(OrbitalEdgeInsets edgeInsets) =>
      OrbitalConstraints(
        minThickness: minThickness + edgeInsets.radial,
        maxThickness: maxThickness + edgeInsets.radial,
        minSweepAngle: minSweepAngle + edgeInsets.angular,
        maxSweepAngle: maxSweepAngle + edgeInsets.angular,
      );

  OrbitalConstraints deflate(OrbitalEdgeInsets edgeInsets) {
    final deflatedMinThickness = math.max(
      0.0,
      minThickness - edgeInsets.radial,
    );
    final deflatedMinSweepAngle = math.max(
      0.0,
      minSweepAngle - edgeInsets.angular,
    );
    return OrbitalConstraints(
      minThickness: deflatedMinThickness,
      maxThickness: math.max(
        deflatedMinThickness,
        maxThickness - edgeInsets.radial,
      ),
      minSweepAngle: deflatedMinSweepAngle,
      maxSweepAngle: math.max(
        deflatedMinSweepAngle,
        maxSweepAngle - edgeInsets.angular,
      ),
    );
  }

  OrbitalSize constrain(OrbitalSize size) => OrbitalSize(
    thickness: clampDouble(size.thickness, minThickness, maxThickness),
    sweepAngle: clampDouble(size.sweepAngle, minSweepAngle, maxSweepAngle),
  );
}
