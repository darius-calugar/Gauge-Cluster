part of 'gauge.dart';

sealed class GaugeFeature {
  const GaugeFeature();

  GaugeFeaturePosition get position;
}

class GaugeBoxFeature extends GaugeFeature {
  const GaugeBoxFeature({
    required this.position,
    required this.angle,
    required this.width,
    required this.color,
  });

  @override
  final GaugeFeatureSectorPosition position;
  final Angle angle;
  final double width;
  final Color color;
}

class GaugeSliceFeature extends GaugeFeature {
  const GaugeSliceFeature({
    required this.position,
    this.color,
    this.gradient,
    this.startAngle = Angle.zero,
    this.sweepAngle = Angle.full,
  }) : assert(color == null || gradient == null),
       assert(sweepAngle >= Angle.zero && sweepAngle <= Angle.full);

  @override
  final GaugeFeatureSectorPosition position;
  final Color? color;
  final Gradient? gradient;
  final Angle startAngle;
  final Angle sweepAngle;
}

class GaugeTextFeature extends GaugeFeature {
  const GaugeTextFeature({
    required this.position,
    required this.angle,
    required this.keepRotation,
    required this.text,
    this.style,
  });

  @override
  final GaugeFeaturePointPosition position;
  final Angle angle;
  final bool keepRotation;
  final String text;
  final TextStyle? style;
}

class GaugeCustomFeature extends GaugeFeature {
  const GaugeCustomFeature({
    required this.position,
    required this.angle,
    required this.keepRotation,
    required this.builder,
  });

  @override
  final GaugeFeaturePointPosition position;
  final Angle angle;
  final bool keepRotation;
  final WidgetBuilder builder;
}
