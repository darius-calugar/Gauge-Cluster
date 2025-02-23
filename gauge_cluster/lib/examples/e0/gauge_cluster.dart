import 'package:flutter/material.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/examples/e0/main_gauge.dart';

class E0GaugeCluster extends StatelessWidget {
  const E0GaugeCluster({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.black1,
        ),
        child: Stack(children: [Center(child: E0MainGauge())]),
      ),
    );
  }
}
