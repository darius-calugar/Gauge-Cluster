import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class CirclePoint extends Equatable {
  const CirclePoint({required this.radius, required this.angle});

  CirclePoint.inset({
    required Circle circle,
    double? innerInset,
    double? outerInset,
    required this.angle,
  }) : assert(innerInset != null || outerInset != null),
       assert(innerInset == null || outerInset == null),
       radius = innerInset ?? (circle.radius - outerInset!);

  CirclePoint.fromOffset(Offset offset)
    : radius = offset.distance,
      angle = Angle.fromRad(offset.direction);

  final double radius;
  final Angle angle;

  operator +(CirclePoint other) =>
      CirclePoint.fromOffset(offset + other.offset);
  operator -(CirclePoint other) =>
      CirclePoint.fromOffset(offset - other.offset);

  Offset get offset => Offset.fromDirection(angle.toRad, radius);

  Alignment alignment(double circleRadius) =>
      Alignment(offset.dx / circleRadius, offset.dy / circleRadius);

  @override
  List<Object?> get props => [radius, angle];
}
