import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:orbital/orbital.dart';

@immutable
extension type const OrbitalOffset._(Offset raw) {
  OrbitalOffset({required double da, required double dr})
    : raw = Offset(da, dr);

  static const zero = OrbitalOffset._(Offset.zero);

  double get da => raw.dx;
  double get dr => raw.dy;

  OrbitalOffset operator +(OrbitalOffset other) =>
      OrbitalOffset._(raw + other.raw);
  OrbitalOffset operator -(OrbitalOffset other) =>
      OrbitalOffset._(raw - other.raw);

  OrbitalSector operator &(OrbitalSize size) =>
      OrbitalSector.fromSEIO(da, da + size.sweepAngle, dr, dr + size.thickness);
}
