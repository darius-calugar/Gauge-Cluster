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
  final double angle;
  final double width;
  final Color color;
}

class GaugeSliceFeature extends GaugeFeature {
  const GaugeSliceFeature({
    required this.position,
    required this.color,
    this.startAngle = 0,
    this.sweepAngle = 360,
  }) : assert(sweepAngle >= 0 && sweepAngle <= 360);

  @override
  final GaugeFeatureSectorPosition position;
  final Color color;
  final double startAngle;
  final double sweepAngle;
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
  final double angle;
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
  final double angle;
  final bool keepRotation;
  final WidgetBuilder builder;
}
