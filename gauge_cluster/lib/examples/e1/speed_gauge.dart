import 'package:flutter/material.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/components/gauge/gauge.dart';
import 'package:gauge_cluster/components/mileage/mileage.dart';

class E1SpeedGauge extends StatelessWidget {
  const E1SpeedGauge({super.key});

  static double radius = 200.0;
  static double diameter = radius * 2;

  final kmTopSpeed = 160;
  final innerTopSpeed = 240;

  @override
  Widget build(BuildContext context) {
    final visibleStartAngle = -210.0;
    final visibleEndAngle = 30.0;
    final visibleSweepAngle = visibleEndAngle - visibleStartAngle;

    final outerSteps = kmTopSpeed ~/ 2 + 1;
    final outerStepAngleSweep = visibleSweepAngle / (outerSteps - 1);

    final innerSteps = innerTopSpeed ~/ 10 + 1;
    final innerStepAngleSweep = visibleSweepAngle / (innerSteps - 1);

    return SizedBox.square(
      dimension: diameter,
      child: Gauge(
        features: [
          // MPH
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(
              outerInset: 55,
            ),
            angle: visibleEndAngle + 15,
            keepRotation: true,
            text: 'MPH',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.white1,
              fontStyle: FontStyle.italic,
            ),
          ),
          for (var step = 0; step < outerSteps; step++)
            if (step % 10 == 0) ...[
              // Steps
              GaugeBoxFeature(
                position: GaugeFeatureSectorPosition(
                  outerInset: 30,
                  thickness: 16,
                ),
                angle: visibleStartAngle + outerStepAngleSweep * step,
                width: 4,
                color: AppColors.white1,
              ),
              // Step labels
              GaugeTextFeature(
                position: GaugeFeaturePointPosition(
                  outerInset: 60,
                ),
                angle: visibleStartAngle + outerStepAngleSweep * step,
                keepRotation: false,
                text: '${step * 2}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.white1,
                ),
              ),
              if (step < outerSteps - 1)
                // Border
                GaugeSliceFeature(
                  position: GaugeFeatureSectorPosition(
                    outerInset: 30,
                    thickness: 2,
                  ),
                  startAngle:
                      visibleStartAngle + step * outerStepAngleSweep + 2,
                  sweepAngle: outerStepAngleSweep * 10 - 4,
                  color: AppColors.white1,
                ),
            ] else if (step % 5 == 0)
              // Half-steps
              GaugeBoxFeature(
                position: GaugeFeatureSectorPosition(
                  outerInset: 36,
                  thickness: 10,
                ),
                angle: visibleStartAngle + outerStepAngleSweep * step,
                width: 2,
                color: AppColors.white1,
              )
            else
              // Quarter-steps
              GaugeBoxFeature(
                position: GaugeFeatureSectorPosition(
                  outerInset: 36,
                  thickness: 2,
                ),
                angle: visibleStartAngle + outerStepAngleSweep * step,
                width: 2,
                color: AppColors.white1,
              ),

          // KMH
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(
              outerInset: 100,
            ),
            angle: visibleEndAngle + 20,
            keepRotation: true,
            text: 'KM/H',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.white2,
              fontStyle: FontStyle.italic,
            ),
          ),
          for (var step = 0; step < innerSteps; step++)
            if (step % 3 == 0) ...[
              // Steps
              GaugeBoxFeature(
                position: GaugeFeatureSectorPosition(
                  outerInset: 80,
                  thickness: 8,
                ),
                angle: visibleStartAngle + innerStepAngleSweep * step,
                width: 2,
                color: AppColors.white2,
              ),
              // Step labels
              GaugeTextFeature(
                position: GaugeFeaturePointPosition(
                  outerInset: 100,
                ),
                angle: visibleStartAngle + innerStepAngleSweep * step,
                keepRotation: false,
                text: '${step * 30}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.white2,
                ),
              ),
            ] else
              // Half-steps
              GaugeBoxFeature(
                position: GaugeFeatureSectorPosition(
                  outerInset: 80,
                  thickness: 2,
                ),
                angle: visibleStartAngle + innerStepAngleSweep * step,
                width: 2,
                color: AppColors.white2,
              ),
          // Mileage
          GaugeCustomFeature(
            position: GaugeFeaturePointPosition(
              innerInset: 50,
            ),
            angle: 90,
            keepRotation: true,
            builder: (context) => Mileage(
              value: 54412,
              digitCount: 6,
            ),
          ),
          // Knob base
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              thickness: 20,
            ),
            color: AppColors.black2,
          ),
          // Pin
          GaugeBoxFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: 40,
            ),
            angle: 280,
            width: 2,
            color: AppColors.red1,
          ),
          // Knob
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              thickness: 16,
            ),
            color: AppColors.black3,
          ),
        ],
      ),
    );
  }
}
