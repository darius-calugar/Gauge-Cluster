import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/examples/e2/gear_bar.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/components/gauge/gauge.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';
import 'package:gauge_cluster/utils/math/units/rot_freq.dart';

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
        carState.revs < carState.redline - 250.rpm
            ? AppColors.blue5
            : carState.revs < carState.redline
            ? AppColors.green5
            : AppColors.red5;
    final secondaryColor =
        carState.revs < carState.redline - 250.rpm
            ? AppColors.blue9
            : carState.revs < carState.redline
            ? AppColors.green9
            : AppColors.red9;

    return SizedBox.square(
      dimension: radius * 2,
      child: Gauge(
        features: [
          // Backgrounds
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(thickness: 200),
            gradient: RadialGradient(
              transform: GradientRotation(startAngle.toRad),
              colors: [AppColors.black4, AppColors.black2],
              stops: [0.8, 1.0],
            ),
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: 120,
              thickness: 80,
            ),
            gradient: RadialGradient(
              transform: GradientRotation(startAngle.toRad),
              colors: [AppColors.black4, AppColors.black2],
              stops: [0.8, 1.0],
            ),
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 80, thickness: 40),
            gradient: RadialGradient(
              transform: GradientRotation(startAngle.toRad),
              colors: [AppColors.black6, AppColors.black4],
              stops: [0.8, 1.0],
            ),
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: 110,
              thickness: 10,
            ),
            startAngle: redlineStartAngle - stepSweepAngle,
            sweepAngle: stepSweepAngle,
            gradient: RadialGradient(
              transform: GradientRotation(startAngle.toRad),
              colors: [AppColors.green8, AppColors.green9],
              stops: [0.8, 1.0],
            ),
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 80, thickness: 40),
            startAngle: redlineStartAngle,
            sweepAngle: redlineSweepAngle + (Angle.bottom - endAngle),
            gradient: RadialGradient(
              transform: GradientRotation(startAngle.toRad),
              colors: [AppColors.red8, AppColors.red9],
              stops: [0.8, 1.0],
            ),
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 80, thickness: 40),
            startAngle: Angle.bottom,
            sweepAngle:
                Angle.top + startAngle + sweepAngle * carState.revsRatio,
            gradient: RadialGradient(
              transform: GradientRotation(startAngle.toRad),
              colors: [primaryColor, secondaryColor],
              stops: [0.8, 1.0],
            ),
          ),
          // Outline
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: 80 - 4,
              thickness: 4,
            ),
            color: AppColors.white9,
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 120, thickness: 2),
            color: AppColors.white9,
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 200, thickness: 2),
            color: AppColors.black6,
          ),
          // Overlay
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.black3.withAlpha(0x00), AppColors.black3],
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
                        ? AppColors.white9
                        : AppColors.red7,
              ),
          // Marker
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: 120 - 4,
              thickness: 6,
            ),
            startAngle: startAngle,
            sweepAngle: sweepAngle * carState.revsRatio,
            color: primaryColor,
          ),
          GaugeBoxFeature(
            position: GaugeFeatureSectorPosition(outerInset: 80, thickness: 42),
            width: 6,
            angle: startAngle + sweepAngle * carState.revsRatio,
            color: primaryColor,
          ),
          // Speed
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(innerInset: 50),
            angle: Angle.top,
            keepRotation: true,
            text: '${carState.speed.toKmh.floor()}',
            style: TextStyle(fontSize: 100, fontWeight: FontWeight.w700),
          ),
          // KMH
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(innerInset: 20),
            angle: Angle.bottom,
            keepRotation: true,
            text: 'KM/H',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          // Gear
          GaugeCustomFeature(
            position: GaugeFeaturePointPosition(innerInset: 80),
            angle: Angle.bottom,
            keepRotation: true,
            builder: (context) => E2GearBar(),
          ),
          // Mileage
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(innerInset: 300),
            angle: Angle.bottom,
            keepRotation: true,
            text: '${carState.mileage.toKm.floor()}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
          ),
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(innerInset: 320),
            angle: Angle.bottom,
            keepRotation: true,
            text: 'KM',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
          ),
          // Time
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(innerInset: 230),
            angle: Angle.bottom,
            keepRotation: true,
            text: DateFormat('HH:mm').format(DateTime.now()),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
