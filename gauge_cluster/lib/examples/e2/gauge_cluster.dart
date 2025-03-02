import 'package:flutter/material.dart';
import 'package:gauge_cluster/examples/e2/fuel_gauge.dart';
import 'package:gauge_cluster/examples/e2/temperature_gauge.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/examples/e2/main_gauge.dart';

class E2GaugeCluster extends StatelessWidget {
  const E2GaugeCluster({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.black.$3,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [E2MainGauge(), E2FuelGauge(), E2TemperatureGauge()],
        ),
      ),
    );
  }
}
