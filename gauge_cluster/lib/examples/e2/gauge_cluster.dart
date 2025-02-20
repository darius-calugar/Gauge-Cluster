import 'package:flutter/material.dart';
import 'package:gauge_cluster/examples/e2/main_gauge.dart';

class E2GaugeCluster extends StatelessWidget {
  const E2GaugeCluster({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [Center(child: E2MainGauge())]);
  }
}
