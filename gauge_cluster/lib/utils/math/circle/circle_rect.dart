import 'package:equatable/equatable.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_line.dart';
import 'package:gauge_cluster/utils/math/circle/circle_point.dart';
import 'package:gauge_cluster/utils/math/circle/circle_ring.dart';
import 'package:gauge_cluster/utils/math/circle/circle_slice.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class CircleRect extends Equatable {
  CircleRect({
    required Circle circle,
    required this.width,
    required this.angle,
    double? innerRadius,
    double? outerRadius,
    double? thickness,
  }) : ring = CircleRing(
         circle: circle,
         innerRadius: innerRadius,
         outerRadius: outerRadius,
         thickness: thickness,
       );

  CircleRect.inset({
    required Circle circle,
    required this.width,
    required this.angle,
    double? innerInset,
    double? outerInset,
    double? thickness,
  }) : ring = CircleRing.inset(
         circle: circle,
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
  CirclePoint get innerMid =>
      CirclePoint(radius: ring.innerRadius, angle: angle);
  CirclePoint get innerStart =>
      innerMid + CirclePoint(radius: width / 2, angle: angle - 90.deg);
  CirclePoint get innerEnd =>
      innerMid + CirclePoint(radius: width / 2, angle: angle + 90.deg);
  CirclePoint get outerMid =>
      CirclePoint(radius: ring.outerRadius, angle: angle);
  CirclePoint get outerStart =>
      outerMid + CirclePoint(radius: width / 2, angle: angle - 90.deg);
  CirclePoint get outerEnd =>
      outerMid + CirclePoint(radius: width / 2, angle: angle + 90.deg);

  CircleLine get innerLine => CircleLine(start: innerStart, end: innerEnd);
  CircleLine get outerLine => CircleLine(start: outerStart, end: outerEnd);
  CircleLine get startLine => CircleLine(start: innerStart, end: outerStart);
  CircleLine get endLine => CircleLine(start: innerEnd, end: outerEnd);

  CircleSlice get innerSlice =>
      CircleSlice(startAngle: innerStart.angle, endAngle: innerEnd.angle);
  CircleSlice get outerSlice =>
      CircleSlice(startAngle: outerStart.angle, endAngle: outerEnd.angle);

  @override
  List<Object?> get props => [width, angle, ring];
}
