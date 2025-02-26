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
    : getPoint = ((circle) => CirclePoint(radius: radius, angle: angle));

  GaugePartPointShape.inset({
    double? innerInset,
    double? outerInset,
    required Angle angle,
  }) : getPoint =
           ((circle) => CirclePoint.inset(
             circle: circle,
             innerInset: innerInset,
             outerInset: outerInset,
             angle: angle,
           ));

  GaugePartPointShape.raw(CirclePoint point) : getPoint = ((_) => point);

  final CirclePoint Function(Circle circle) getPoint;

  @override
  List<Object?> get props => [getPoint];
}

/// Gauge shape that represents a rectangle.
///
/// Gauge parts built with this shape fill the rectangle.
final class GaugePartRectShape extends GaugePartShape {
  GaugePartRectShape({
    required double width,
    required Angle angle,
    double? innerRadius,
    double? outerRadius,
    double? thickness,
  }) : getRect =
           ((circle) => CircleRect(
             circle: circle,
             width: width,
             angle: angle,
             innerRadius: innerRadius,
             outerRadius: outerRadius,
             thickness: thickness,
           ));

  GaugePartRectShape.inset({
    required double width,
    required Angle angle,
    double? innerInset,
    double? outerInset,
    double? thickness,
  }) : getRect =
           ((circle) => CircleRect.inset(
             circle: circle,
             width: width,
             angle: angle,
             innerInset: innerInset,
             outerInset: outerInset,
             thickness: thickness,
           ));

  GaugePartRectShape.raw(CircleRect rect) : getRect = ((_) => rect);

  final CircleRect Function(Circle circle) getRect;

  @override
  List<Object?> get props => [getRect];
}

/// Gauge shape that represents a sector on a circle.
///
/// Gauge parts built with this shape fill the sector.
final class GaugePartSectorShape extends GaugePartShape {
  GaugePartSectorShape({
    double? innerRadius,
    double? outerRadius,
    double? thickness,
    Angle? startAngle,
    Angle? endAngle,
    Angle? sweepAngle,
  }) : getSector =
           ((circle) => CircleSector(
             circle: circle,
             innerRadius: innerRadius,
             outerRadius: outerRadius,
             thickness: thickness,
             startAngle: startAngle,
             endAngle: endAngle,
             sweepAngle: sweepAngle,
           ));

  GaugePartSectorShape.inset({
    double? innerInset,
    double? outerInset,
    double? thickness,
    Angle? startAngle,
    Angle? endAngle,
    Angle? sweepAngle,
  }) : getSector =
           ((circle) => CircleSector.inset(
             circle: circle,
             innerInset: innerInset,
             outerInset: outerInset,
             thickness: thickness,
             startAngle: startAngle,
             endAngle: endAngle,
             sweepAngle: sweepAngle,
           ));

  GaugePartSectorShape.raw(CircleSector sector) : getSector = ((_) => sector);

  final CircleSector Function(Circle circle) getSector;

  @override
  List<Object?> get props => [getSector];
}
