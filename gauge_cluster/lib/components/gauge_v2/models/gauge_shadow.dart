import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/utils/math/circle/circle_point.dart';

class GaugeShadow extends Shadow {
  GaugeShadow({
    required super.color,
    required super.blurRadius,
    CirclePoint offset = CirclePoint.center,
  }) : super(offset: offset.offset);
}
