import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:orbital/orbital.dart';

@immutable
extension type const OrbitalSize._(Size raw) {
  OrbitalSize({required double sweepAngle, required double thickness})
    : raw = Size(sweepAngle, thickness);

  static const zero = OrbitalSize._(Size.zero);

  double get sweepAngle => raw.width;
  double get thickness => raw.height;

  OrbitalSize inflate(OrbitalEdgeInsets edgeInsets) => OrbitalSize(
    thickness: thickness + edgeInsets.radial,
    sweepAngle: sweepAngle + edgeInsets.angular,
  );

  OrbitalSize deflate(OrbitalEdgeInsets edgeInsets) => OrbitalSize(
    thickness: math.max(0.0, thickness - edgeInsets.radial),
    sweepAngle: math.max(0.0, sweepAngle - edgeInsets.angular),
  );
}
