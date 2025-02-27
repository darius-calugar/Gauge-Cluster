import 'package:equatable/equatable.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_point.dart';
import 'package:gauge_cluster/utils/math/circle/circle_rect.dart';
import 'package:gauge_cluster/utils/math/circle/circle_sector.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

/// Base class for gauge shapes.
///
/// Gauge shapes define the geometry of the gauge parts.
sealed class GaugeShape extends Equatable {
  const GaugeShape();
}

/// Gauge shape that represents a point on a circle.
///
/// Gauge parts built with this shape are centered at the point.
final class GaugePointShape extends GaugeShape {
  GaugePointShape({required double radius, required Angle angle})
    : getPoint = ((circle) => CirclePoint(radius: radius, angle: angle));

  GaugePointShape.inset({
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

  GaugePointShape.raw(CirclePoint point) : getPoint = ((_) => point);

  final CirclePoint Function(Circle circle) getPoint;

  @override
  List<Object?> get props => [getPoint];
}

/// Gauge shape that represents a rectangle.
///
/// Gauge parts built with this shape fill the rectangle.
final class GaugeRectShape extends GaugeShape {
  GaugeRectShape({
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

  GaugeRectShape.inset({
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

  GaugeRectShape.raw(CircleRect rect) : getRect = ((_) => rect);

  final CircleRect Function(Circle circle) getRect;

  @override
  List<Object?> get props => [getRect];
}

/// Gauge shape that represents a sector on a circle.
///
/// Gauge parts built with this shape fill the sector.
final class GaugeSectorShape extends GaugeShape {
  GaugeSectorShape({
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

  GaugeSectorShape.inset({
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

  GaugeSectorShape.raw(CircleSector sector) : getSector = ((_) => sector);

  final CircleSector Function(Circle circle) getSector;

  @override
  List<Object?> get props => [getSector];
}
