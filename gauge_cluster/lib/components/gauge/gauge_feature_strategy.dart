part of 'gauge.dart';

sealed class GaugeFeatureStrategy {
  const GaugeFeatureStrategy();
}

class GaugeFeatureSingleStrategy extends GaugeFeatureStrategy {
  const GaugeFeatureSingleStrategy({
    required this.angleStart,
  });

  final double angleStart;
}

class GaugeFeatureMultipleStrategy extends GaugeFeatureStrategy {
  const GaugeFeatureMultipleStrategy({
    required this.count,
    required this.angleStart,
    required this.angleEnd,
  });

  final int count;
  final double angleStart;
  final double angleEnd;
}
