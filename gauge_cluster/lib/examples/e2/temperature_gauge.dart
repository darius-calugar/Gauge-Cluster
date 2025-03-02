import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/components/gauge/gauge.dart';
import 'package:gauge_cluster/utils/assets.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class E2TemperatureGauge extends StatelessWidget {
  const E2TemperatureGauge({super.key});

  static double radius = 400.0;

  @override
  Widget build(BuildContext context) {
    final carState = context.watch<CarCubit>().state;

    final baseInset = 20.0;

    final startAngle = Angle.top + 30.deg;
    final endAngle = Angle.full - 10.deg;
    final sweepAngle = endAngle - startAngle;

    final stepCount = 40;
    final stepSweepAngle = sweepAngle / stepCount;

    final primaryColor =
        carState.temperatureSignal ? AppColors.red : AppColors.white.$1;
    final secondaryColor =
        carState.temperatureSignal ? AppColors.darkRed.$4 : AppColors.white.$7;

    return SizedBox.square(
      dimension: radius * 2,
      child: Gauge(
        features: [
          // Backgrounds
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: baseInset + 14,
              thickness: 15,
            ),
            startAngle: startAngle,
            sweepAngle: sweepAngle,
            color: AppColors.black.$3,
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: baseInset + 14,
              thickness: 15,
            ),
            startAngle: endAngle - sweepAngle * carState.temperature,
            sweepAngle: sweepAngle * carState.temperature,
            gradient: RadialGradient(
              transform: GradientRotation(startAngle.toRad),
              colors: [primaryColor, secondaryColor],
              stops: [0.95, 1.0],
            ),
          ),
          for (var step = 0; step <= stepCount; step++)
            // Steps
            GaugeBoxFeature(
              position: GaugeFeatureSectorPosition(
                outerInset: baseInset + 2,
                thickness: 4,
              ),
              angle: startAngle + stepSweepAngle * step,
              width: 2,
              color: AppColors.white.$7,
            ),
          // Limits
          GaugeBoxFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: baseInset + 2,
              thickness: 30,
            ),
            angle: startAngle - stepSweepAngle,
            width: 4,
            color: AppColors.darkRed.$6,
          ),
          GaugeBoxFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: baseInset + 2,
              thickness: 30,
            ),
            angle: endAngle + stepSweepAngle,
            width: 4,
            color: AppColors.white.$7,
          ),
          // Icon
          GaugeCustomFeature(
            position: GaugeFeaturePointPosition(outerInset: baseInset + 20),
            angle: startAngle - 6.deg,
            keepRotation: true,
            builder:
                (context) => SvgIcon(
                  SvgIcons.temperature,
                  color: AppColors.white.$1,
                  size: 30,
                ),
          ),
        ],
      ),
    );
  }
}
