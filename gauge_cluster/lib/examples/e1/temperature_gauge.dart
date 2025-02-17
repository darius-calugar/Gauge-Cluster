import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/components/gauge/gauge.dart';

class E1TemperatureGauge extends StatelessWidget {
  const E1TemperatureGauge({super.key});

  static double radius = 60.0;
  static double diameter = radius * 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: diameter,
      child: Gauge(
        features: [
          for (var step = 0; step < 4; step++) ...[
            // Steps
            GaugeBoxFeature(
              position: GaugeFeatureSectorPosition(
                outerInset: 10,
                thickness: 8,
              ),
              angle: 160 + 40 * step.toDouble(),
              width: 2,
              color: AppColors.white1,
            ),
          ],
          // Border
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: 10,
              thickness: 2,
            ),
            startAngle: 160,
            sweepAngle: 120,
            color: AppColors.white1,
          ),
          // Limits
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: 10,
              thickness: 12,
            ),
            startAngle: 145,
            sweepAngle: 8,
            color: AppColors.white1,
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: 10,
              thickness: 12,
            ),
            startAngle: 285,
            sweepAngle: 8,
            color: AppColors.red2,
          ),
          // Labels
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(
              outerInset: 32,
            ),
            angle: 145,
            keepRotation: true,
            text: 'E',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
          ),
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(
              outerInset: 32,
            ),
            angle: 285,
            keepRotation: true,
            text: 'F',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
          ),
          // Icon
          GaugeCustomFeature(
            position: GaugeFeaturePointPosition(
              outerInset: 32,
            ),
            angle: 220,
            keepRotation: true,
            builder: (context) => SvgPicture.asset(
              'assets/svgs/icons/temperature.svg',
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                AppColors.white1,
                BlendMode.srcIn,
              ),
            ),
          ),
          // Knob base
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              thickness: 14,
            ),
            color: AppColors.black2,
          ),
          // Pin
          GaugeBoxFeature(
            position: GaugeFeatureSectorPosition(
              outerInset: 15,
            ),
            angle: 260,
            width: 2,
            color: AppColors.red1,
          ),
          // Knob
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(
              thickness: 10,
            ),
            color: AppColors.black3,
          ),
        ],
      ),
    );
  }
}
