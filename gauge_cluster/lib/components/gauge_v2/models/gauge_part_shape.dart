import 'package:equatable/equatable.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
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
final class GaugePartPointShape extends GaugePartShape {
  GaugePartPointShape({required double radius, required Angle angle})
    : point = CirclePoint(radius: radius, angle: angle);

  const GaugePartPointShape.raw({required this.point});

  final CirclePoint point;

  @override
  List<Object?> get props => [point];
}

/// Gauge shape that represents a rectangle.
///
/// Gauge parts built with this shape fill the rectangle.
final class GaugePartRectShape extends GaugePartShape {
  GaugePartRectShape({
    required Circle circle,
    required double width,
    required Angle angle,
    double? innerRadius,
    double? outerRadius,
    double? thickness,
  }) : rect = CircleRect(
         circle: circle,
         width: width,
         angle: angle,
         innerRadius: innerRadius,
         outerRadius: outerRadius,
         thickness: thickness,
       );

  GaugePartRectShape.inset({
    required Circle circle,
    required double width,
    required Angle angle,
    double? innerInset,
    double? outerInset,
    double? thickness,
  }) : rect = CircleRect.inset(
         circle: circle,
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

/// Gauge shape that represents a sector on a circle.
///
/// Gauge parts built with this shape fill the sector.
final class GaugePartSectorShape extends GaugePartShape {
  GaugePartSectorShape({
    required Circle circle,
    double? innerRadius,
    double? outerRadius,
    double? thickness,
    Angle? startAngle,
    Angle? endAngle,
    Angle? sweepAngle,
  }) : sector = CircleSector(
         circle: circle,
         innerRadius: innerRadius,
         outerRadius: outerRadius,
         thickness: thickness,
         startAngle: startAngle,
         endAngle: endAngle,
         sweepAngle: sweepAngle,
       );

  GaugePartSectorShape.inset({
    required Circle circle,
    double? innerInset,
    double? outerInset,
    double? thickness,
    Angle? startAngle,
    Angle? endAngle,
    Angle? sweepAngle,
  }) : sector = CircleSector.inset(
         circle: circle,
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
