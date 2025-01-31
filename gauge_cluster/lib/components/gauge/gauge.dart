import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gauge_cluster/math.dart';

part 'gauge_feature.dart';
part 'gauge_feature_shape.dart';
part 'gauge_feature_strategy.dart';

class Gauge extends StatelessWidget {
  const Gauge({
    super.key,
    required this.features,
  });

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
              // Features
              for (final feature in features)
                ...switch (feature.strategy) {
                  final GaugeFeatureSingleStrategy strategy => [
                      Builder(builder: (context) {
                        return switch (feature.shape) {
                          final GaugeFeatureBoxShape shape => _BoxFeatureWidget(
                              shape: shape,
                              radius: radius,
                              angle: strategy.angleStart,
                            ),
                          GaugeFeatureSliceShape shape => _SliceFeatureWidget(
                              shape: shape,
                              radius: radius,
                              angle: strategy.angleStart,
                            ),
                          GaugeFeatureTextShape shape => _TextFeatureWidget(
                              shape: shape,
                              radius: radius,
                              angle: strategy.angleStart,
                              step: 0,
                            ),
                          GaugeFeatureCustomShape shape => _CustomFeatureWidget(
                              shape: shape,
                              radius: radius,
                              angle: strategy.angleStart,
                              step: 0,
                            ),
                        };
                      }),
                    ],
                  final GaugeFeatureMultipleStrategy strategy => [
                      for (var step = 0; step < strategy.count; step++)
                        Builder(
                          builder: (context) {
                            final stepDelta = strategy.count > 1
                                ? step / (strategy.count - 1)
                                : 0.0;
                            final angle = lerpDouble(strategy.angleStart,
                                strategy.angleEnd, stepDelta)!;

                            return switch (feature.shape) {
                              final GaugeFeatureBoxShape shape =>
                                _BoxFeatureWidget(
                                  shape: shape,
                                  radius: radius,
                                  angle: angle,
                                ),
                              GaugeFeatureSliceShape shape =>
                                _SliceFeatureWidget(
                                  shape: shape,
                                  radius: radius,
                                  angle: angle,
                                ),
                              GaugeFeatureTextShape shape => _TextFeatureWidget(
                                  shape: shape,
                                  radius: radius,
                                  angle: angle,
                                  step: step,
                                ),
                              GaugeFeatureCustomShape shape =>
                                _CustomFeatureWidget(
                                  shape: shape,
                                  radius: radius,
                                  angle: angle,
                                  step: step,
                                ),
                            };
                          },
                        ),
                    ],
                },
            ],
          ),
        );
      },
    );
  }
}

class _SliceClipper extends CustomClipper<Path> {
  const _SliceClipper({
    required this.startAngle,
    required this.sweepAngle,
  });

  final double startAngle;
  final double sweepAngle;

  @override
  bool shouldReclip(covariant _SliceClipper oldClipper) {
    return startAngle != oldClipper.startAngle ||
        sweepAngle != oldClipper.sweepAngle;
  }

  @override
  Path getClip(Size size) {
    final radius = size.width / 2;
    final center = size.center(Offset.zero);
    final rect = Rect.fromCircle(center: center, radius: radius);

    return Path()
      ..addArc(
        rect,
        startAngle,
        sweepAngle,
      )
      ..lineTo(center.dx, center.dy);
  }
}

class _BoxFeatureWidget extends StatelessWidget {
  const _BoxFeatureWidget({
    required this.shape,
    required this.radius,
    required this.angle,
  });

  final GaugeFeatureBoxShape shape;
  final double radius;
  final double angle;

  @override
  Widget build(BuildContext context) {
    final length = min(shape.length, radius - shape.inset);

    return Container(
      width: length,
      height: shape.width,
      color: shape.color,
      transform: Matrix4.identity()
        ..translate(length / 2, shape.width / 2, 0)
        ..rotateZ(angle * toRadians)
        ..translate(radius - length - shape.inset, -shape.width / 2, 0),
    );
  }
}

class _SliceFeatureWidget extends StatelessWidget {
  const _SliceFeatureWidget({
    required this.shape,
    required this.radius,
    required this.angle,
  });

  final GaugeFeatureSliceShape shape;
  final double radius;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _SliceClipper(
        startAngle: angle * toRadians,
        sweepAngle: min(shape.angleSpan, 360) * toRadians,
      ),
      child: Container(
        height: radius * 2 - shape.inset * 2,
        width: radius * 2 - shape.inset * 2,
        decoration: ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(
              color: shape.color,
              width: min(radius - shape.inset, shape.width),
            ),
          ),
        ),
      ),
    );
  }
}

class _TextFeatureWidget extends StatelessWidget {
  const _TextFeatureWidget({
    required this.shape,
    required this.radius,
    required this.angle,
    required this.step,
  });

  final GaugeFeatureTextShape shape;
  final double radius;
  final double angle;
  final int step;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.0,
      height: 0.0,
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateZ(angle * toRadians)
        ..translate(radius - shape.inset, 0, 0)
        ..rotateZ((shape.keepRotation ? -angle : 90) * toRadians),
      child: OverflowBox(
        maxHeight: double.infinity,
        maxWidth: double.infinity,
        child: Text(
          shape.textBuilder(step),
          style: shape.style,
        ),
      ),
    );
  }
}

class _CustomFeatureWidget extends StatelessWidget {
  const _CustomFeatureWidget({
    required this.shape,
    required this.radius,
    required this.angle,
    required this.step,
  });

  final GaugeFeatureCustomShape shape;
  final double radius;
  final double angle;
  final int step;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.0,
      height: 0.0,
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateZ(angle * toRadians)
        ..translate(radius - shape.inset, 0, 0)
        ..rotateZ((shape.keepRotation ? -angle : 90) * toRadians),
      child: OverflowBox(
        maxHeight: double.infinity,
        maxWidth: double.infinity,
        child: Builder(
          builder: shape.builder,
        ),
      ),
    );
  }
}
