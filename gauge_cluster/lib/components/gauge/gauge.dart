import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

part 'gauge_feature_position.dart';
part 'gauge_feature.dart';

class Gauge extends StatelessWidget {
  const Gauge({super.key, required this.features});

  final List<GaugeFeature> features;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final diameter = min(constraints.maxHeight, constraints.maxWidth);
        final radius = diameter / 2;

        return SizedBox.square(
          dimension: diameter,
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              for (final feature in features)
                switch (feature) {
                  GaugeBoxFeature feature => _BoxFeatureWidget(
                    feature: feature,
                    radius: radius,
                  ),
                  GaugeSliceFeature feature => _SliceFeatureWidget(
                    feature: feature,
                    radius: radius,
                  ),
                  GaugeTextFeature feature => _TextFeatureWidget(
                    feature: feature,
                    radius: radius,
                  ),
                  GaugeCustomFeature feature => _CustomFeatureWidget(
                    feature: feature,
                    radius: radius,
                  ),
                },
            ],
          ),
        );
      },
    );
  }
}

class _SliceClipper extends CustomClipper<Path> {
  const _SliceClipper({required this.feature, required this.radius});

  final GaugeSliceFeature feature;
  final double radius;

  @override
  bool shouldReclip(covariant _SliceClipper oldClipper) =>
      feature != oldClipper.feature || radius != oldClipper.radius;

  @override
  Path getClip(Size size) {
    final position = feature.position.evaluate(radius);

    final center = size.center(Offset.zero);
    final startAngleRadians = feature.startAngle;
    final sweepAngleRadians = feature.sweepAngle;
    final innerRect = Rect.fromCircle(
      center: center,
      radius: position.innerRadius,
    );
    final outerRect = Rect.fromCircle(
      center: center,
      radius: position.outerRadius,
    );

    final innerPath = Path()..addOval(innerRect);
    final outerPath =
        Path()
          ..addArc(outerRect, startAngleRadians.toRad, sweepAngleRadians.toRad)
          ..lineTo(center.dx, center.dy);

    return Path.combine(PathOperation.difference, outerPath, innerPath);
  }
}

// Feature Widgets =============================================================

class _BoxFeatureWidget extends StatelessWidget {
  const _BoxFeatureWidget({required this.feature, required this.radius});

  final GaugeBoxFeature feature;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final position = feature.position.evaluate(radius);

    final size = Size(position.thickness, feature.width);

    return SizedBox.fromSize(
      size: size,
      child: Container(
        color: feature.color,
        transform:
            Matrix4.identity()
              ..translate(size.width / 2, size.height / 2, 0)
              ..rotateZ(feature.angle.toRad)
              ..translate(position.innerInset, -size.height / 2, 0),
      ),
    );
  }
}

class _SliceFeatureWidget extends StatelessWidget {
  const _SliceFeatureWidget({required this.feature, required this.radius});

  final GaugeSliceFeature feature;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final position = feature.position.evaluate(radius);

    return ClipPath(
      clipper: _SliceClipper(feature: feature, radius: radius),
      child: Container(
        height: radius * 2 - position.outerInset * 2,
        width: radius * 2 - position.outerInset * 2,
        decoration: BoxDecoration(
          color: feature.color,
          gradient: feature.gradient,
        ),
      ),
    );
  }
}

class _TextFeatureWidget extends StatelessWidget {
  const _TextFeatureWidget({required this.feature, required this.radius});

  final GaugeTextFeature feature;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final position = feature.position.evaluate(radius);

    return Container(
      width: 0.0,
      height: 0.0,
      alignment: Alignment.center,
      transform:
          Matrix4.identity()
            ..rotateZ(feature.angle.toRad)
            ..translate((position.innerInset + position.outerRadius) / 2, 0, 0)
            ..rotateZ(feature.keepRotation ? -feature.angle.toRad : 90.deg.toRad),
      child: OverflowBox(
        maxHeight: double.infinity,
        maxWidth: double.infinity,
        child: Text(feature.text, style: feature.style),
      ),
    );
  }
}

class _CustomFeatureWidget extends StatelessWidget {
  const _CustomFeatureWidget({required this.feature, required this.radius});

  final GaugeCustomFeature feature;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final position = feature.position.evaluate(radius);

    return Container(
      width: 0.0,
      height: 0.0,
      alignment: Alignment.center,
      transform:
          Matrix4.identity()
            ..rotateZ(feature.angle.toRad)
            ..translate((position.innerInset + position.outerRadius) / 2, 0, 0)
            ..rotateZ(feature.keepRotation ? -feature.angle.toRad : 90.deg.toRad),
      child: OverflowBox(
        maxHeight: double.infinity,
        maxWidth: double.infinity,
        child: Builder(builder: feature.builder),
      ),
    );
  }
}
