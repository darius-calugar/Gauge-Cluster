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
    final visibleAngleStart = -210.0;
    final visibleAngleEnd = 30.0;
    final visibleAngleSweep = visibleAngleEnd - visibleAngleStart;

    final outerSteps = (kmTopSpeed ~/ 20) + 1;
    final outerStepAngleSweep = visibleAngleSweep / (outerSteps - 1);

    final innerSteps = (innerTopSpeed ~/ 30) + 1;

    return SizedBox.square(
      dimension: diameter,
      child: Gauge(
        features: [
          // MPH
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: visibleAngleEnd + 15,
            ),
            shape: GaugeFeatureTextShape(
              inset: 55,
              keepRotation: true,
              textBuilder: (_) => 'MPH',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.white1,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          // Quarter-steps
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: outerSteps + 9 * (outerSteps - 1),
              angleStart: visibleAngleStart,
              angleEnd: visibleAngleEnd,
            ),
            shape: GaugeFeatureBoxShape(
              inset: 36,
              length: 2,
              width: 2,
              color: AppColors.white2,
            ),
          ),
          // Half-steps
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: outerSteps + 1 * (outerSteps - 1),
              angleStart: visibleAngleStart,
              angleEnd: visibleAngleEnd,
            ),
            shape: GaugeFeatureBoxShape(
              inset: 36,
              length: 10,
              width: 2,
              color: AppColors.white1,
            ),
          ),
          // Steps
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: outerSteps,
              angleStart: visibleAngleStart,
              angleEnd: visibleAngleEnd,
            ),
            shape: GaugeFeatureBoxShape(
              inset: 30,
              length: 16,
              width: 4,
              color: AppColors.white1,
            ),
          ),
          // Step labels
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: outerSteps,
              angleStart: visibleAngleStart,
              angleEnd: visibleAngleEnd,
            ),
            shape: GaugeFeatureTextShape(
              inset: 60,
              keepRotation: false,
              textBuilder: (step) => '${step * 20}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColors.white1,
              ),
            ),
          ),
          // Border
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: outerSteps - 1,
              angleStart: visibleAngleStart + 2,
              angleEnd: visibleAngleEnd - outerStepAngleSweep + 2,
            ),
            shape: GaugeFeatureSliceShape(
              inset: 30,
              angleSpan: outerStepAngleSweep - 4,
              width: 2,
              color: AppColors.white1,
            ),
          ),
          // KMH
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: visibleAngleEnd + 20,
            ),
            shape: GaugeFeatureTextShape(
              inset: 100,
              keepRotation: true,
              textBuilder: (_) => 'KM/H',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.white2,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          // Half-steps
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: innerSteps + 3 * (innerSteps - 1),
              angleStart: visibleAngleStart,
              angleEnd: visibleAngleEnd,
            ),
            shape: GaugeFeatureBoxShape(
              inset: 80,
              length: 2,
              width: 2,
              color: AppColors.white2,
            ),
          ),
          // Steps
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: innerSteps,
              angleStart: visibleAngleStart,
              angleEnd: visibleAngleEnd,
            ),
            shape: GaugeFeatureBoxShape(
              inset: 80,
              length: 8,
              width: 2,
              color: AppColors.white2,
            ),
          ),
          // Step labels
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: innerSteps,
              angleStart: visibleAngleStart,
              angleEnd: visibleAngleEnd,
            ),
            shape: GaugeFeatureTextShape(
              inset: 100,
              keepRotation: false,
              textBuilder: (step) => '${step * 30}',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.white2,
              ),
            ),
          ),
          // Mileage
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 90,
            ),
            shape: GaugeFeatureCustomShape(
              inset: 150,
              keepRotation: true,
              builder: (context) => Mileage(
                value: 54_412,
                digitCount: 6,
              ),
            ),
          ),
          // Knob base
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 0,
            ),
            shape: GaugeFeatureSliceShape(
              inset: 180,
              angleSpan: double.infinity,
              width: double.infinity,
              color: AppColors.black2,
            ),
          ),
          // Pin
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 200,
            ),
            shape: GaugeFeatureBoxShape(
              inset: 40,
              length: double.infinity,
              width: 2,
              color: AppColors.red1,
            ),
          ),
          // Knob
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 0,
            ),
            shape: GaugeFeatureSliceShape(
              inset: 185,
              angleSpan: double.infinity,
              width: double.infinity,
              color: AppColors.black3,
            ),
          ),
        ],
      ),
    );
  }
}
