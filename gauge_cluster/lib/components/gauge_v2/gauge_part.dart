import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge_part_decoration.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge_part_shape.dart';

class GaugePart extends Equatable {
  const GaugePart({required this.shape, this.decoration, this.child});

  final GaugePartShape shape;
  final GaugePartDecoration? decoration;
  final Widget? child;

  @override
  List<Object?> get props => [shape, decoration, child];
}
