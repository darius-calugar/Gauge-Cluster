import 'package:flutter/material.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/examples/0_debug/main_gauge.dart';

class DebugGaugeCluster extends StatelessWidget {
  const DebugGaugeCluster({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.black1,
        ),
        child: Stack(children: [Center(child: DebugMainGauge())]),
      ),
    );
  }
}
