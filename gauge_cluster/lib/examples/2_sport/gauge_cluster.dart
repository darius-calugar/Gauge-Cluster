import 'package:flutter/material.dart';
import 'package:gauge_cluster/examples/2_sport/gauges/main_gauge.dart';
import 'package:gauge_cluster/utils/app_colors.dart';

class SportGaugeCluster extends StatelessWidget {
  const SportGaugeCluster({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 800,
        width: 800,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.black3,
        ),
        child: Stack(alignment: Alignment.center, children: [SportMainGauge()]),
      ),
    );
  }
}
