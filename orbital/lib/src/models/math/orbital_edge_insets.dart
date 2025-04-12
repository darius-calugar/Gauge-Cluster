import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

@immutable
extension type const OrbitalEdgeInsets._(EdgeInsetsDirectional raw) {
  OrbitalEdgeInsets.only({
    double inner = 0,
    double outer = 0,
    double start = 0,
    double end = 0,
  }) : raw = EdgeInsetsDirectional.only(
         start: start,
         end: end,
         top: outer,
         bottom: inner,
       );

  OrbitalEdgeInsets.symmetric({double radial = 0, double angular = 0})
    : raw = EdgeInsetsDirectional.symmetric(
        horizontal: angular,
        vertical: radial,
      );

  static const zero = OrbitalEdgeInsets._(EdgeInsetsDirectional.zero);

  double get start => raw.start;
  double get end => raw.end;
  double get inner => raw.bottom;
  double get outer => raw.top;

  double get angular => raw.horizontal;
  double get radial => raw.vertical;
}
