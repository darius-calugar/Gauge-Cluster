import 'package:flutter/material.dart';
import 'package:gauge_cluster/examples/0_debug/gauges/main_gauge.dart';
import 'package:gauge_cluster/examples/0_debug/widgets/color_pallette.dart';

class DebugGaugeCluster extends StatelessWidget {
  const DebugGaugeCluster({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      width: 1200,
      child: Stack(
        children: [
          Positioned.fill(right: 800, child: DebugColorPallette()),
          Positioned.fill(left: 400, child: DebugMainGauge()),
        ],
      ),
    );
  }
}
