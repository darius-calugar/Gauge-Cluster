import 'package:equatable/equatable.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class CirclePoint extends Equatable {
  const CirclePoint({required this.radius, required this.angle});

  final double radius;
  final Angle angle;

  operator +(CirclePoint other) =>
      CirclePoint(radius: radius + other.radius, angle: angle + other.angle);
  operator -(CirclePoint other) =>
      CirclePoint(radius: radius - other.radius, angle: angle - other.angle);

  @override
  List<Object?> get props => [radius, angle];
}
