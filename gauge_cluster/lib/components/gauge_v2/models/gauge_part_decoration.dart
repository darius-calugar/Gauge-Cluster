import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/utils/math/circle/circle_slice.dart';

/// Base class for gauge decorations.
///
/// Gauge decorations define the appearance of the gauge parts.
sealed class GaugePartDecoration extends Equatable {
  const GaugePartDecoration();
}

final class GaugePartSolidDecoration extends GaugePartDecoration {
  const GaugePartSolidDecoration({required this.color});

  final Color color;

  @override
  List<Object?> get props => [color];
}

final class GaugePartSweepGradientDecoration extends GaugePartDecoration {
  const GaugePartSweepGradientDecoration({
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
