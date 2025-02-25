import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/utils/math/circle/circle_slice.dart';

/// Base class for gauge fills.
///
/// Gauge fills define the appearance of the gauge parts.
sealed class GaugePartFill extends Equatable {
  const GaugePartFill();
}

/// Solid fill.
///
/// The part is filled with a solid color.
final class GaugePartSolidFill extends GaugePartFill {
  const GaugePartSolidFill({required this.color});

  final Color color;

  @override
  List<Object?> get props => [color];
}

/// Sweep gradient fill.
///
/// The part is filled with a sweep gradient.
final class GaugePartSweepGradientFill extends GaugePartFill {
  const GaugePartSweepGradientFill({
    required this.colors,
    this.stops = const [0, 1],
    this.slice,
  });

  final List<Color> colors;
  final List<double> stops;
  final CircleSlice? slice;

  SweepGradient getGradient(CircleSlice slice) => SweepGradient(
    stops: stops,
    colors: colors,
    transform: GradientRotation((this.slice ?? slice).startAngle.toRad),
    endAngle: (this.slice ?? slice).sweepAngle.toRad,
  );

  @override
  List<Object?> get props => [stops, colors];
}
