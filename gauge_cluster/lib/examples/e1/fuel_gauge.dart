import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/components/gauge/gauge.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/utils/assets.dart';

class E1FuelGauge extends StatelessWidget {
  const E1FuelGauge({super.key});

  static double radius = 70.0;
  static double diameter = radius * 2;

  @override
  Widget build(BuildContext context) {
    final carState = context.watch<CarCubit>().state;

    final startAngle = 160;
    final endAngle = 280;

    return SizedBox.square(
      dimension: diameter,
      child: Gauge(
        features: [
          for (var step = 0; step < 5; step++) ...[
            // Steps
            GaugeBoxFeature(
              position: GaugeFeatureSectorPosition(
                outerInset: 10,
                thickness: 8,
              ),
              angle: 160 + 30 * step.toDouble(),
              width: 2,
              color: AppColors.white1,
            ),
          ],
          // Border
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 10, thickness: 2),
            startAngle: 160,
            sweepAngle: 120,
            color: AppColors.white1,
          ),
          // Limits
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 10, thickness: 12),
            startAngle: 145,
            sweepAngle: 8,
            color: AppColors.red2,
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 10, thickness: 12),
            startAngle: 285,
            sweepAngle: 8,
            color: AppColors.white1,
          ),
          // Labels
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(outerInset: 32),
            angle: 145,
            keepRotation: true,
            text: 'E',
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(outerInset: 32),
            angle: 285,
            keepRotation: true,
            text: 'F',
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
          // Icon
          GaugeCustomFeature(
            position: GaugeFeaturePointPosition(outerInset: 32),
            angle: 220,
            keepRotation: true,
            builder:
                (context) => SvgIcon(SvgIcons.fuel, color: AppColors.white1),
          ),
          // Knob base
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(thickness: 14),
            color: AppColors.black2,
          ),
          // Pin
          GaugeBoxFeature(
            position: GaugeFeatureSectorPosition(outerInset: 15),
            angle: lerpDouble(startAngle, endAngle, carState.fuel)!,
            width: 2,
            color: AppColors.red1,
          ),
          // Knob
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(thickness: 10),
            color: AppColors.black3,
          ),
        ],
      ),
    );
  }
}
