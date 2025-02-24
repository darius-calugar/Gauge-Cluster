import 'package:equatable/equatable.dart';
import 'package:gauge_cluster/utils/math/circle/circle_point.dart';
import 'package:gauge_cluster/utils/math/circle/circle_rect.dart';
import 'package:gauge_cluster/utils/math/circle/circle_sector.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

/// Base class for gauge shapes.
///
/// Gauge shapes define the geometry of the gauge parts.
sealed class GaugePartShape extends Equatable {
  const GaugePartShape();
}

/// Gauge shape that represents a point on a circle.
///
/// Gauge parts built with this shape are centered at the point.
class GaugePartPointShape extends GaugePartShape {
  GaugePartPointShape({required double radius, required Angle angle})
    : point = CirclePoint(radius: radius, angle: angle);

  const GaugePartPointShape.raw({required this.point});

  final CirclePoint point;

  @override
  List<Object?> get props => [point];
}

/// Gauge shape that represents a sector on a circle.
///
/// Gauge parts built with this shape fill the sector.
class GaugePartSectorShape extends GaugePartShape {
  GaugePartSectorShape({
    required double circleRadius,
    double? innerRadius,
    double? outerRadius,
    double? thickness,
    Angle? startAngle,
    Angle? endAngle,
    Angle? sweepAngle,
  }) : sector = CircleSector(
         circleRadius: circleRadius,
         innerRadius: innerRadius,
         outerRadius: outerRadius,
         thickness: thickness,
         startAngle: startAngle,
         endAngle: endAngle,
         sweepAngle: sweepAngle,
       );

  GaugePartSectorShape.inset({
    required double circleRadius,
    double? innerInset,
    double? outerInset,
    double? thickness,
    Angle? startAngle,
    Angle? endAngle,
    Angle? sweepAngle,
  }) : sector = CircleSector.inset(
         circleRadius: circleRadius,
         innerInset: innerInset,
         outerInset: outerInset,
         thickness: thickness,
         startAngle: startAngle,
         endAngle: endAngle,
         sweepAngle: sweepAngle,
       );

  const GaugePartSectorShape.raw({required this.sector});

  final CircleSector sector;

  @override
  List<Object?> get props => [sector];
}

/// Gauge shape that represents a rectangle.
///
/// Gauge parts built with this shape fill the rectangle.
class GaugePartRectShape extends GaugePartShape {
  GaugePartRectShape({
    required double circleRadius,
    required double width,
    required Angle angle,
    double? innerRadius,
    double? outerRadius,
    double? thickness,
  }) : rect = CircleRect(
         circleRadius: circleRadius,
         width: width,
         angle: angle,
         innerRadius: innerRadius,
         outerRadius: outerRadius,
         thickness: thickness,
       );

  GaugePartRectShape.inset({
    required double circleRadius,
    required double width,
    required Angle angle,
    double? innerInset,
    double? outerInset,
    double? thickness,
  }) : rect = CircleRect.inset(
         circleRadius: circleRadius,
         width: width,
         angle: angle,
         innerInset: innerInset,
         outerInset: outerInset,
         thickness: thickness,
       );

  final CircleRect rect;

  @override
  List<Object?> get props => [rect];
}
