import 'package:flutter/rendering.dart';
import 'package:orbital/orbital.dart';

extension type const OrbitalAlignment._(Alignment raw) {
  OrbitalAlignment({double a = 0, double r = 0}) : raw = Alignment(a, r);

  static const center = OrbitalAlignment._(Alignment.center);
  static const innerStart = OrbitalAlignment._(Alignment.topLeft);
  static const innerCenter = OrbitalAlignment._(Alignment.topCenter);
  static const innerEnd = OrbitalAlignment._(Alignment.topRight);
  static const outerStart = OrbitalAlignment._(Alignment.bottomLeft);
  static const outerCenter = OrbitalAlignment._(Alignment.bottomCenter);
  static const outerEnd = OrbitalAlignment._(Alignment.bottomRight);

  double get a => raw.x;
  double get r => raw.y;

  /// Returns the offset that is this fraction in the direction of the given offset.
  OrbitalOffset alongOffset(OrbitalOffset other) {
    final double centerA = other.da / 2.0;
    final double centerR = other.dr / 2.0;
    return OrbitalOffset(da: centerA + a * centerA, dr: centerR + r * centerR);
  }

  /// Returns the offset that is this fraction within the given size.
  OrbitalOffset alongSize(OrbitalSize other) {
    final double centerA = other.sweepAngle / 2.0;
    final double centerR = other.thickness / 2.0;
    return OrbitalOffset(da: centerA + a * centerA, dr: centerR + r * centerR);
  }
}
