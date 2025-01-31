part of 'gauge.dart';

class GaugeFeature {
  const GaugeFeature({
    required this.strategy,
    required this.shape,
  });

  final GaugeFeatureStrategy strategy;
  final GaugeFeatureShape shape;
}
