import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/components/gauge/gauge.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class E1RevGauge extends StatelessWidget {
  const E1RevGauge({super.key});

  static double radius = 300.0;

  @override
  Widget build(BuildContext context) {
    final carState = context.watch<CarCubit>().state;

    final visibleStartAngle = -210.0.deg;
    final visibleEndAngle = -50.0.deg;
    final visibleSweepAngle = visibleEndAngle - visibleStartAngle;

    final steps = (carState.maxRevs.toRpm ~/ 100) + 1;
    final stepAngleSweep = visibleSweepAngle / (steps - 1);
    final redlineStep = carState.redline.toRpm ~/ 100;
    final redlineStepSnapped = (redlineStep / 10).round() * 10;

    return SizedBox.square(
      dimension: radius * 2,
      child: Gauge(
        features: [
          // RPM legend
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(outerInset: 100),
            angle: Angle.top,
            keepRotation: true,
            text: 'RPM x 1000',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.white2,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
          for (var step = 0; step < steps; step++)
            if (step % 10 == 0) ...[
              // Steps
              GaugeBoxFeature(
                position: GaugeFeatureSectorPosition(
                  outerInset: 30,
                  thickness: 16,
                ),
                angle: visibleStartAngle + stepAngleSweep * step,
                width: 4,
                color:
                    step < redlineStepSnapped
                        ? AppColors.white1
                        : AppColors.red2,
              ),
              // Step labels
              GaugeTextFeature(
                position: GaugeFeaturePointPosition(outerInset: 60),
                angle: visibleStartAngle + stepAngleSweep * step,
                keepRotation: false,
                text: '${step ~/ 10}',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              if (step < redlineStepSnapped)
                // Border
                GaugeSliceFeature(
                  position: GaugeFeatureSectorPosition(
                    outerInset: 30,
                    thickness: 2,
                  ),
                  startAngle: visibleStartAngle + stepAngleSweep * step + 2.deg,
                  sweepAngle: stepAngleSweep * 10 - 4.deg,
                  color: AppColors.white1,
                )
              else if (step < steps - 1)
                // Border
                GaugeSliceFeature(
                  position: GaugeFeatureSectorPosition(
                    outerInset: 30,
                    thickness: 2,
                  ),
                  startAngle: visibleStartAngle + stepAngleSweep * step,
                  sweepAngle: stepAngleSweep * 10,
                  color: AppColors.red2,
                ),
            ] else if (step < redlineStepSnapped)
              // Quarter-steps
              GaugeBoxFeature(
                position: GaugeFeatureSectorPosition(
                  outerInset: 36,
                  thickness: 2,
                ),
                angle: visibleStartAngle + stepAngleSweep * step,
                width: 2,
                color: AppColors.white1,
              )
            else
              // Redline Quarter-steps
              GaugeBoxFeature(
                position: GaugeFeatureSectorPosition(
                  outerInset: 34,
                  thickness: 4,
                ),
                angle: visibleStartAngle + stepAngleSweep * step,
                width: 2,
                color: AppColors.red2,
              ),
          // Gears
          for (var gear = carState.minGears; gear <= carState.maxGears; gear++)
            GaugeTextFeature(
              position: GaugeFeaturePointPosition(outerInset: 15),
              angle: 145.deg + 8.deg * (gear + 1),
              keepRotation: true,
              text: switch (gear) {
                < 0 => 'R',
                0 => 'N',
                _ => '$gear',
              },
              style: TextStyle(
                color:
                    gear == carState.gear ? AppColors.red1 : AppColors.black3,
                fontWeight: FontWeight.w600,
              ),
            ),
          // Knob base
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(thickness: 20),
            color: AppColors.black2,
          ),
          // Pin
          GaugeBoxFeature(
            position: GaugeFeatureSectorPosition(outerInset: 40),
            angle: Angle.lerp(
              visibleStartAngle,
              visibleEndAngle,
              carState.revsRatio,
            ),
            width: 3,
            color: AppColors.red1,
          ),
          // Knob
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(thickness: 16),
            color: AppColors.black3,
          ),
        ],
      ),
    );
  }
}
