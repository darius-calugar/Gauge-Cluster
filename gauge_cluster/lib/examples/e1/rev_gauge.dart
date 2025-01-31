import 'package:flutter/material.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/components/gauge/gauge.dart';
import 'package:gauge_cluster/examples/e1/fuel_gauge.dart';

class E1RevGauge extends StatelessWidget {
  const E1RevGauge({super.key});

  static double radius = 200.0;
  static double diameter = radius * 2;

  final int maxRevs = 6;

  @override
  Widget build(BuildContext context) {
    final visibleAngleStart = -210.0;
    final visibleAngleEnd = -55.0;
    final visibleAngleSweep = visibleAngleEnd - visibleAngleStart;

    final steps = maxRevs + 1;
    final stepAngleSweep = visibleAngleSweep / (steps - 1);

    return SizedBox.square(
      dimension: diameter,
      child: Gauge(
        features: [
          // RPM legend
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: -90,
            ),
            shape: GaugeFeatureTextShape(
              inset: 100,
              keepRotation: true,
              textBuilder: (context) => 'RPM x 1000',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.white2,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          // Quarter-steps
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: (steps - 2) + 9 * (steps - 3),
              angleStart: visibleAngleStart,
              angleEnd: visibleAngleEnd - (stepAngleSweep * 2),
            ),
            shape: GaugeFeatureBoxShape(
              inset: 36,
              length: 2,
              width: 2,
              color: AppColors.white2,
            ),
          ),
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: 19,
              angleStart: visibleAngleStart + (stepAngleSweep * 4),
              angleEnd: visibleAngleEnd,
            ),
            shape: GaugeFeatureBoxShape(
              inset: 36,
              length: 8,
              width: 2,
              color: AppColors.red2,
            ),
          ),
          // Steps
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: steps - 3,
              angleStart: visibleAngleStart,
              angleEnd: visibleAngleEnd - (stepAngleSweep * 3),
            ),
            shape: GaugeFeatureBoxShape(
              inset: 30,
              length: 16,
              width: 4,
              color: AppColors.white1,
            ),
          ),
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: 3,
              angleStart: visibleAngleStart + (stepAngleSweep * 4),
              angleEnd: visibleAngleEnd,
            ),
            shape: GaugeFeatureBoxShape(
              inset: 30,
              length: 16,
              width: 4,
              color: AppColors.red2,
            ),
          ),
          // Step labels
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: steps,
              angleStart: visibleAngleStart,
              angleEnd: visibleAngleEnd,
            ),
            shape: GaugeFeatureTextShape(
              inset: 60,
              keepRotation: false,
              textBuilder: (step) => '$step',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          // Border
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: steps - 3,
              angleStart: visibleAngleStart + 2,
              angleEnd: visibleAngleEnd - (stepAngleSweep * 3) + 2,
            ),
            shape: GaugeFeatureSliceShape(
              inset: 30,
              angleSpan: stepAngleSweep - 4,
              width: 2,
              color: AppColors.white1,
            ),
          ),
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: visibleAngleStart + (stepAngleSweep * 4),
            ),
            shape: GaugeFeatureSliceShape(
              inset: 30,
              angleSpan: stepAngleSweep * 2,
              width: 4,
              color: AppColors.red2,
            ),
          ),
          // Gears
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: 8,
              angleStart: 145,
              angleEnd: 190,
            ),
            shape: GaugeFeatureTextShape(
              inset: 15,
              keepRotation: true,
              textBuilder: (step) => switch (step) {
                0 => 'R',
                1 => 'N',
                _ => '${step - 1}',
              },
              style: TextStyle(
                color: AppColors.black3,
              ),
            ),
          ),
          // Fuel
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 115,
            ),
            shape: GaugeFeatureCustomShape(
              inset: 110,
              keepRotation: true,
              builder: (context) => E1FuelGauge(),
            ),
          ),
          // Temperature
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 65,
            ),
            shape: GaugeFeatureCustomShape(
              inset: 110,
              keepRotation: true,
              builder: (context) => E1FuelGauge(),
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
