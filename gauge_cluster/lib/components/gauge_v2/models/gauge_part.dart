import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_fill.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_shape.dart';

class GaugePart extends Equatable {
  const GaugePart({
    required this.shape,
    this.fill,
    this.child,
    this.isRotated = false,
  });

  final GaugePartShape shape;
  final GaugePartFill? fill;
  final Widget? child;
  final bool isRotated;

  @override
  List<Object?> get props => [shape, fill, child, isRotated];
}
