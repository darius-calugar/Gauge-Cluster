import 'package:flutter/material.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/examples/e2/main_gauge.dart';

class E2GaugeCluster extends StatelessWidget {
  const E2GaugeCluster({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.black1,
        ),
        child: Stack(children: [Center(child: E2MainGauge())]),
      ),
    );
  }
}
