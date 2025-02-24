import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/components/gauge/gauge.dart';
import 'package:gauge_cluster/utils/assets.dart';
import 'package:gauge_cluster/utils/math/angle_math.dart';

class E2FuelGauge extends StatelessWidget {
  const E2FuelGauge({super.key});

  static double radius = 400.0;

  @override
  Widget build(BuildContext context) {
    final carState = context.watch<CarCubit>().state;

    final baseInset = 20.0;

    final startAngle = Angle.left + 10.deg;
    final endAngle = Angle.up - 30.deg;
    final sweepAngle = endAngle - startAngle;

    final stepCount = 40;
    final stepSweepAngle = sweepAngle / stepCount;

    final primaryColor =
        carState.fuelSignal ? AppColors.red1 : AppColors.white1;
    final secondaryColor =
        carState.fuelSignal ? AppColors.red2 : AppColors.white2;

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
            color: AppColors.black2,
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: baseInset + 14,
              thickness: 15,
            ),
            startAngle: startAngle,
            sweepAngle: sweepAngle * carState.fuel,
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
              color: AppColors.white2,
            ),
          // Limits
          GaugeBoxFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: baseInset + 2,
              thickness: 30,
            ),
            angle: startAngle - stepSweepAngle,
            width: 4,
            color: AppColors.red3,
          ),
          GaugeBoxFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: baseInset + 2,
              thickness: 30,
            ),
            angle: endAngle + stepSweepAngle,
            width: 4,
            color: AppColors.white2,
          ),
          // Icon
          GaugeCustomFeature(
            position: GaugeFeaturePointPosition(outerInset: baseInset + 20),
            angle: endAngle + 6.deg,
            keepRotation: true,
            builder:
                (context) =>
                    SvgIcon(SvgIcons.fuel, color: AppColors.white1, size: 30),
          ),
        ],
      ),
    );
  }
}
