import 'package:equatable/equatable.dart';
import 'package:gauge_cluster/utils/math/circle/circle_ring.dart';
import 'package:gauge_cluster/utils/math/circle/circle_slice.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class CircleSector extends Equatable {
  CircleSector({
    required double circleRadius,
    double? innerRadius,
    double? outerRadius,
    double? thickness,
    Angle? startAngle,
    Angle? endAngle,
    Angle? sweepAngle,
  }) : ring = CircleRing(
         circleRadius: circleRadius,
         innerRadius: innerRadius,
         outerRadius: outerRadius,
         thickness: thickness,
       ),
       slice = CircleSlice(
         startAngle: startAngle,
         endAngle: endAngle,
         sweepAngle: sweepAngle,
       );

  CircleSector.inset({
    required double circleRadius,
    double? innerInset,
    double? outerInset,
    double? thickness,
    Angle? startAngle,
    Angle? endAngle,
    Angle? sweepAngle,
  }) : ring = CircleRing.inset(
         circleRadius: circleRadius,
         innerInset: innerInset,
         outerInset: outerInset,
         thickness: thickness,
       ),
       slice = CircleSlice(
         startAngle: startAngle,
         endAngle: endAngle,
         sweepAngle: sweepAngle,
       );

  CircleSector.raw({CircleRing? ring, CircleSlice? slice})
    : ring = ring ?? CircleRing(circleRadius: 0),
      slice = slice ?? CircleSlice();

  final CircleRing ring;
  final CircleSlice slice;

  double get innerRadius => ring.innerRadius;
  double get outerRadius => ring.outerRadius;
  double get thickness => ring.thickness;
  Angle get startAngle => slice.startAngle;
  Angle get endAngle => slice.endAngle;
  Angle get sweepAngle => slice.sweepAngle;

  @override
  List<Object?> get props => [ring, slice];
}
