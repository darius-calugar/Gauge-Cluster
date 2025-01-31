part of 'gauge.dart';

abstract interface class GaugeFeaturePosition {
  ConcreteGaugeFeaturePosition evaluate(double radius);
}

class GaugeFeatureSectorPosition implements GaugeFeaturePosition {
  const GaugeFeatureSectorPosition({
    this.innerInset,
    this.outerInset,
    this.thickness,
  }) : assert(thickness == null || innerInset == null || outerInset == null);

  final double? innerInset;
  final double? outerInset;
  final double? thickness;

  @override
  ConcreteGaugeFeaturePosition evaluate(double radius) {
    switch (thickness) {
      case null:
        final innerInset = this.innerInset ?? 0;
        final outerInset = this.outerInset ?? 0;
        final thickness = radius - innerInset - outerInset;
        assert(radius >= innerInset + outerInset + thickness);
        return ConcreteGaugeFeaturePosition(
          innerInset: innerInset,
          outerInset: outerInset,
          thickness: thickness,
          innerRadius: innerInset,
          outerRadius: radius - outerInset,
        );
      case double thickness:
        final innerInset = this.innerInset ??
            (this.outerInset != null
                ? (radius - thickness - this.outerInset!)
                : 0);
        final outerInset = this.outerInset ?? (radius - thickness - innerInset);
        assert(radius >= innerInset + outerInset + thickness);
        return ConcreteGaugeFeaturePosition(
          innerInset: innerInset,
          outerInset: outerInset,
          thickness: thickness,
          innerRadius: innerInset,
          outerRadius: radius - outerInset,
        );
    }
  }
}

class GaugeFeaturePointPosition implements GaugeFeaturePosition {
  const GaugeFeaturePointPosition({
    this.innerInset,
    this.outerInset,
  }) : assert(innerInset == null || outerInset == null);

  final double? innerInset;
  final double? outerInset;

  @override
  ConcreteGaugeFeaturePosition evaluate(double radius) {
    final innerInset = this.innerInset ?? (radius - this.outerInset!);
    final outerInset = this.outerInset ?? (radius - this.innerInset!);
    assert(radius >= innerInset + outerInset);
    return ConcreteGaugeFeaturePosition(
      innerInset: innerInset,
      outerInset: outerInset,
      thickness: 0,
      innerRadius: innerInset,
      outerRadius: radius - outerInset,
    );
  }
}

class ConcreteGaugeFeaturePosition {
  const ConcreteGaugeFeaturePosition({
    required this.innerInset,
    required this.outerInset,
    required this.thickness,
    required this.innerRadius,
    required this.outerRadius,
  });

  final double innerInset;
  final double outerInset;
  final double thickness;
  final double innerRadius;
  final double outerRadius;

  double evalThickness(double radius) => radius;
}
