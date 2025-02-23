import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/components/gauge/gauge.dart';
import 'package:gauge_cluster/utils/math.dart';

class E2MainGauge extends StatelessWidget {
  const E2MainGauge({super.key});

  static double radius = 300.0;
  static double topSpeed = 160;

  @override
  Widget build(BuildContext context) {
    final carState = context.watch<CarCubit>().state;

    final startAngle = -200.0;
    final endAngle = 20.0;
    final sweepAngle = endAngle - startAngle;

    return SizedBox.square(
      dimension: radius * 2,
      child: Gauge(
        features: [
          // Revs
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 50, thickness: 2),
            startAngle: startAngle,
            sweepAngle: sweepAngle,
            color: AppColors.white1,
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 54, thickness: 40),
            startAngle: startAngle,
            sweepAngle: sweepAngle,
            color: AppColors.white3,
          ),
          GaugeSliceFeature(
            position: GaugeFeatureSectorPosition(outerInset: 54, thickness: 40),
            startAngle: startAngle,
            sweepAngle: sweepAngle * carState.revsProgress,
            gradient: SweepGradient(
              transform: GradientRotation(startAngle * toRadians),
              endAngle: sweepAngle * toRadians,
              colors: [AppColors.yellow1, AppColors.orange1],
            ),
          ),
          // Steps
          // Speed
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(innerInset: 60),
            angle: -90,
            keepRotation: true,
            text: '${carState.speed.floor()}',
            style: TextStyle(fontSize: 100, fontWeight: FontWeight.w700),
          ),
          // KMH
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(innerInset: 0),
            angle: -90,
            keepRotation: true,
            text: 'KM/H',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          // Time
          GaugeTextFeature(
            position: GaugeFeaturePointPosition(innerInset: 100),
            angle: 90,
            keepRotation: true,
            text: '13:53',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
