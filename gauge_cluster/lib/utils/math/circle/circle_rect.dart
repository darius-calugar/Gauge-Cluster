import 'package:equatable/equatable.dart';
import 'package:gauge_cluster/utils/math/circle/circle_point.dart';
import 'package:gauge_cluster/utils/math/circle/circle_ring.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class CircleRect extends Equatable {
  CircleRect({
    required double circleRadius,
    required this.width,
    required this.angle,
    double? innerRadius,
    double? outerRadius,
    double? thickness,
  }) : ring = CircleRing(
         circleRadius: circleRadius,
         innerRadius: innerRadius,
         outerRadius: outerRadius,
         thickness: thickness,
       );

  CircleRect.inset({
    required double circleRadius,
    required this.width,
    required this.angle,
    double? innerInset,
    double? outerInset,
    double? thickness,
  }) : ring = CircleRing.inset(
         circleRadius: circleRadius,
         innerInset: innerInset,
         outerInset: outerInset,
         thickness: thickness,
       );

  const CircleRect.raw({
    required this.width,
    required this.angle,
    required this.ring,
  });

  final double width;
  final Angle angle;
  final CircleRing ring;

  double get innerRadius => ring.innerRadius;
  double get outerRadius => ring.outerRadius;
  double get thickness => ring.thickness;
  double get height => ring.thickness;

  CirclePoint get center => CirclePoint(
    radius: (ring.innerRadius + ring.outerRadius) / 2,
    angle: angle,
  );
  CirclePoint get innerStart =>
      CirclePoint(radius: ring.innerRadius, angle: angle) +
      CirclePoint(radius: width / 2, angle: angle - 90.deg);
  CirclePoint get innerEnd =>
      CirclePoint(radius: ring.innerRadius, angle: angle) +
      CirclePoint(radius: width / 2, angle: angle + 90.deg);
  CirclePoint get outerStart =>
      CirclePoint(radius: ring.outerRadius, angle: angle) +
      CirclePoint(radius: width / 2, angle: angle - 90.deg);
  CirclePoint get outerEnd =>
      CirclePoint(radius: ring.outerRadius, angle: angle) +
      CirclePoint(radius: width / 2, angle: angle + 90.deg);

  @override
  List<Object?> get props => [width, angle, ring];
}
