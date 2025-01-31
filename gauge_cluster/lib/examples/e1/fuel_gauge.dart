import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/components/gauge/gauge.dart';

class E1FuelGauge extends StatelessWidget {
  const E1FuelGauge({super.key});

  static double radius = 60.0;
  static double diameter = radius * 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: diameter,
      child: Gauge(
        features: [
          // Steps
          GaugeFeature(
            strategy: GaugeFeatureMultipleStrategy(
              count: 4,
              angleStart: 160,
              angleEnd: 280,
            ),
            shape: GaugeFeatureBoxShape(
              inset: 10,
              length: 8,
              width: 2,
              color: AppColors.white1,
            ),
          ),
          // Border
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 160,
            ),
            shape: GaugeFeatureSliceShape(
              inset: 10,
              angleSpan: 120,
              width: 2,
              color: AppColors.white1,
            ),
          ),
          // Limits
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 145,
            ),
            shape: GaugeFeatureSliceShape(
              inset: 10,
              angleSpan: 8,
              width: 12,
              color: AppColors.red2,
            ),
          ),
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 285,
            ),
            shape: GaugeFeatureSliceShape(
              inset: 10,
              angleSpan: 8,
              width: 12,
              color: AppColors.white1,
            ),
          ),
          // Labels
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 145,
            ),
            shape: GaugeFeatureTextShape(
              inset: 32,
              keepRotation: true,
              textBuilder: (_) => 'E',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
            ),
          ),
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 285,
            ),
            shape: GaugeFeatureTextShape(
              inset: 32,
              keepRotation: true,
              textBuilder: (_) => 'F',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
            ),
          ),
          // Icon
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 220,
            ),
            shape: GaugeFeatureCustomShape(
              inset: 32,
              keepRotation: true,
              builder: (context) => SvgPicture.asset(
                'assets/svgs/icons/fuel.svg',
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  AppColors.white1,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          // Knob base
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 0,
            ),
            shape: GaugeFeatureSliceShape(
              inset: 52,
              angleSpan: double.infinity,
              width: double.infinity,
              color: AppColors.black2,
            ),
          ),
          // Pin
          GaugeFeature(
            strategy: GaugeFeatureSingleStrategy(
              angleStart: 230,
            ),
            shape: GaugeFeatureBoxShape(
              inset: 15,
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
              inset: 55,
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
