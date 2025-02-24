import 'package:equatable/equatable.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge_part_shape.dart';

class GaugePart extends Equatable {
  const GaugePart({required this.shape});

  final GaugePartShape shape;

  @override
  List<Object?> get props => [shape];
}
