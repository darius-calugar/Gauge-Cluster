import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_line.dart';
import 'package:gauge_cluster/utils/math/circle/circle_ring.dart';
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

/// Linear gradient fill.
///
/// The part is filled with a linear gradient.
final class GaugePartLinearGradientFill extends GaugePartFill {
  const GaugePartLinearGradientFill({
    required this.colors,
    this.stops,
    this.line,
  });

  final List<Color> colors;
  final List<double>? stops;
  final CircleLine? line;

  LinearGradient getGradient(Circle circle, CircleLine line) => LinearGradient(
    colors: colors,
    stops: stops,
    begin: (this.line ?? line).start.alignmentIn(circle),
    end: (this.line ?? line).end.alignmentIn(circle),
  );

  @override
  List<Object?> get props => [colors, stops, line];
}

/// Sweep gradient fill.
///
/// The part is filled with a sweep gradient.
final class GaugePartSweepGradientFill extends GaugePartFill {
  const GaugePartSweepGradientFill({
    required this.colors,
    this.stops,
    this.slice,
  });

  final List<Color> colors;
  final List<double>? stops;
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

/// Radial gradient fill.
///
/// The part is filled with a radial gradient.
final class GaugePartRadialGradientFill extends GaugePartFill {
  const GaugePartRadialGradientFill({
    required this.colors,
    this.stops,
    this.ring,
  });

  final List<Color> colors;
  final List<double>? stops;
  final CircleRing? ring;

  RadialGradient getGradient(Circle circle, CircleRing ring) {
    final stops =
        this.stops ??
        [for (var i = 0; i < colors.length; i++) i / (colors.length - 1)];
    return RadialGradient(
      colors: colors,
      stops: [
        for (final stop in stops)
          ((this.ring ?? ring).innerRadius / circle.radius) +
              stop * ((this.ring ?? ring).thickness / circle.radius),
      ],
    );
  }

  @override
  List<Object?> get props => [colors, stops, ring];
}
