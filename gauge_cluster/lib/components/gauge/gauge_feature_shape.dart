part of 'gauge.dart';

sealed class GaugeFeatureShape {
  const GaugeFeatureShape();
}

class GaugeFeatureBoxShape extends GaugeFeatureShape {
  const GaugeFeatureBoxShape({
    required this.inset,
    required this.length,
    required this.width,
    required this.color,
  });

  final double inset;
  final double length;
  final double width;
  final Color color;
}

class GaugeFeatureSliceShape extends GaugeFeatureShape {
  const GaugeFeatureSliceShape({
    required this.inset,
    required this.angleSpan,
    required this.width,
    required this.color,
  });

  final double inset;
  final double angleSpan;
  final double width;
  final Color color;
}

class GaugeFeatureTextShape extends GaugeFeatureShape {
  const GaugeFeatureTextShape({
    required this.inset,
    required this.keepRotation,
    required this.textBuilder,
    this.style,
  });

  final double inset;
  final bool keepRotation;
  final String Function(int step) textBuilder;
  final TextStyle? style;
}

class GaugeFeatureCustomShape extends GaugeFeatureShape {
  const GaugeFeatureCustomShape({
    required this.inset,
    required this.keepRotation,
    required this.builder,
  });

  final double inset;
  final bool keepRotation;
  final WidgetBuilder builder;
}
