import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/components/gauge/gauge.dart';
import 'package:gauge_cluster/utils/math/angle_math.dart';
import 'package:gauge_cluster/utils/math/rot_freq_math.dart';

class E2MainGauge extends StatelessWidget {
  const E2MainGauge({super.key});

  static double radius = 400.0;
  static double topSpeed = 160;

  @override
  Widget build(BuildContext context) {
    final carState = context.watch<CarCubit>().state;

    final startAngle = -200.deg;
    final endAngle = 20.deg;
    final sweepAngle = endAngle - startAngle;

    final fullStepInterval = 4;
    final stepCount =
        RotFreq.ratio(
          carState.maxRevs,
          RotFreq.unit / fullStepInterval,
        ).floor();
    final redlineStep =
        RotFreq.ratio(
          carState.maxRevs * carState.redlineRatio,
          RotFreq.unit / fullStepInterval,
        ).floor();
    final stepSweepAngle = sweepAngle / stepCount;

    final redlineStartAngle = startAngle + (sweepAngle * carState.redlineRatio);
    final redlineEndAngle = endAngle;
    final redlineSweepAngle = redlineEndAngle - redlineStartAngle;

    final primaryColor =
        carState.revs < carState.redline ? AppColors.yellow1 : AppColors.red1;
    final secondaryColor =
        carState.revs < carState.redline ? AppColors.yellow5 : AppColors.red5;

    return SizedBox.square(
      dimension: radius * 2,
      child: Gauge(
        features: [
          // Backgrounds
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: 120,
              thickness: 80,
            ),
            gradient: RadialGradient(
              transform: GradientRotation(startAngle.toRad),
              colors: [AppColors.black2, AppColors.black1],
              stops: [0.8, 1.0],
            ),
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 80, thickness: 40),
            gradient: RadialGradient(
              transform: GradientRotation(startAngle.toRad),
              colors: [AppColors.black3, AppColors.black2],
              stops: [0.75, 1.0],
            ),
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 80, thickness: 40),
            startAngle: redlineStartAngle,
            sweepAngle: redlineSweepAngle + (Angle.down - endAngle),
            gradient: RadialGradient(
              transform: GradientRotation(startAngle.toRad),
              colors: [AppColors.red3, AppColors.red5],
              stops: [0.75, 1.0],
            ),
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 80, thickness: 40),
            startAngle: Angle.down,
            sweepAngle: Angle.up + startAngle + sweepAngle * carState.revsRatio,
            gradient: RadialGradient(
              transform: GradientRotation(startAngle.toRad),
              colors: [primaryColor, secondaryColor],
              stops: [0.75, 1.0],
            ),
          ),
          // Outline
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 80, thickness: 2),
            color: AppColors.white2,
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 120, thickness: 1),
            color: AppColors.white2,
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 200, thickness: 2),
            color: AppColors.black3,
          ),
          // Overlay
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.black1.withAlpha(0x00), AppColors.black1],
              stops: [0.3, .75],
            ),
          ),
          for (var step = 0; step <= stepCount; step++)
            if (step % fullStepInterval == 0) ...[
              // Full Steps
              GaugeBoxFeature(
                position: GaugeFeatureSectorPosition(
                  outerInset: 100,
                  thickness: 20,
                ),
                angle: startAngle + stepSweepAngle * step,
                width: 4,
                color: AppColors.white1,
              ),
              GaugeBoxFeature(
                position: GaugeFeatureSectorPosition(
                  outerInset: 116,
                  thickness: 4,
                ),
                angle: startAngle + stepSweepAngle * step,
                width: 4,
                color: primaryColor,
              ),
              GaugeTextFeature(
                position: GaugeFeaturePointPosition(outerInset: 150),
                angle: startAngle + stepSweepAngle * step,
                keepRotation: true,
                text: '${step ~/ fullStepInterval}',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 40),
              ),
            ] else
              // Steps
              GaugeBoxFeature(
                position: GaugeFeatureSectorPosition(
                  outerInset: 110,
                  thickness: 10,
                ),
                angle: startAngle + stepSweepAngle * step,
                width: 2,
                color:
                    carState.revs >= (carState.maxRevs / stepCount) * step
                        ? primaryColor
                        : step < redlineStep
                        ? AppColors.white3
                        : AppColors.red3,
              ),
          // Revs
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 116, thickness: 5),
            startAngle: startAngle,
            sweepAngle: sweepAngle * carState.revsRatio,
            color: primaryColor,
          ),
          // Rev Marker
          GaugeBoxFeature(
            position: GaugeFeatureSectorPosition(outerInset: 80, thickness: 40),
            width: 4,
            angle: startAngle + sweepAngle * carState.revsRatio,
            color: primaryColor,
          ),
          // Speed
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(innerInset: 50),
            angle: Angle.up,
            keepRotation: true,
            text: '${carState.speed.toKmh.floor()}',
            style: TextStyle(fontSize: 100, fontWeight: FontWeight.w700),
          ),
          // KMH
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(innerInset: 20),
            angle: Angle.down,
            keepRotation: true,
            text: 'KM/H',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          // Time
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(innerInset: 100),
            angle: Angle.down,
            keepRotation: true,
            text: '13:53',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
