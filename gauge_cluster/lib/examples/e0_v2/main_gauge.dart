import 'package:flutter/material.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge_part_shape.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class E0MainGauge extends StatelessWidget {
  const E0MainGauge({super.key});

  static double circleRadius = 400.0;

  @override
  Widget build(BuildContext context) {
    final uStepCount = 20;
    final vStepCount = 20;

    final uStep = Angle.full / uStepCount;
    final vStep = circleRadius / vStepCount;

    return SizedBox.square(
      dimension: circleRadius * 2,
      child: Gauge(
        parts: [
          GaugePart(
            shape: GaugePartSectorShape.inset(
              circleRadius: circleRadius,
              outerInset: 40,
              sweepAngle: 50.deg,
            ),
          ),
          GaugePart(
            shape: GaugePartSectorShape(
              circleRadius: circleRadius,
              outerRadius: 0,
              startAngle: 90.deg,
              sweepAngle: 50.deg,
            ),
          ),
          GaugePart(
            shape: GaugePartRectShape.inset(
              circleRadius: circleRadius,
              width: 20,
              angle: -50.deg,
              innerInset: 20,
              outerInset: 70,
            ),
          ),
          for (var u = 0; u < uStepCount; u++) ...[
            for (var v = 0; v < vStepCount; v++) ...[
              GaugePart(
                shape: GaugePartPointShape(radius: vStep * v, angle: uStep * u),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
