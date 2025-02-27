import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_fill.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_shape.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_shadow.dart';
import 'package:gauge_cluster/utils/math/circle/circle_point.dart';

sealed class BaseGaugePart extends Equatable {
  const BaseGaugePart();
}

class GaugePart extends BaseGaugePart {
  const GaugePart({
    required this.shape,
    this.fill,
    this.centerOffset = CirclePoint.center,
    this.shadows,
    this.child,
    this.isRotated = false,
  });

  final GaugePartShape shape;
  final GaugePartFill? fill;
  final CirclePoint centerOffset;
  final List<GaugeShadow>? shadows;
  final Widget? child;
  final bool isRotated;

  @override
  List<Object?> get props => [
    shape,
    fill,
    centerOffset,
    shadows,
    child,
    isRotated,
  ];
}

class CompositeGaugePart extends BaseGaugePart {
  const CompositeGaugePart({required this.parts});

  final List<GaugePart> parts;

  @override
  List<Object?> get props => [parts];
}
