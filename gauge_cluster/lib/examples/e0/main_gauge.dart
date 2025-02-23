import 'package:flutter/material.dart';
import 'package:gauge_cluster/components/gauge/gauge.dart';

class E0MainGauge extends StatelessWidget {
  const E0MainGauge({super.key});

  static double radius = 300.0;

  @override
  Widget build(BuildContext context) {
    final vStepCount = 100;

    final vStep = radius / vStepCount;

    return SizedBox.square(
      dimension: radius * 2,
      child: Gauge(
        features: [
          for (var v = 0; v < vStepCount; v++) ...[
            GaugeSliceFeature(
              position: GaugeFeatureSectorPosition(
                innerInset: v * vStep,
                thickness: vStep + 1,
              ),
              startAngle: 0,
              sweepAngle: 360,
              gradient: SweepGradient(
                colors: [
                  Color.fromARGB(
                    0xff,
                    0x00,
                    (v / vStepCount * 0xff).floor(),
                    0x00,
                  ),
                  Color.fromARGB(
                    0xff,
                    0xff,
                    (v / vStepCount * 0xff).floor(),
                    0x00,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
