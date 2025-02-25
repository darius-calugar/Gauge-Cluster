import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge_part_decoration.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge_part_shape.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/utils/assets.dart';
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
          for (var u = 0; u < uStepCount; u++) ...[
            for (var v = 0; v < vStepCount; v++) ...[
              GaugePart(
                shape: GaugePartSectorShape(
                  circleRadius: circleRadius,
                  innerRadius: vStep * v,
                  thickness: vStep,
                  startAngle: uStep * u,
                  sweepAngle: uStep,
                ),
                decoration: GaugePartDecoration(
                  color: Color.fromARGB(
                    255,
                    (u / uStepCount * 255).toInt(),
                    (v / vStepCount * 255).toInt(),
                    0,
                  ),
                ),
              ),
            ],
          ],
          GaugePart(
            shape: GaugePartPointShape(radius: 200, angle: Angle.up),
            decoration: GaugePartDecoration(color: AppColors.white1),
            child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
          ),
          GaugePart(
            shape: GaugePartSectorShape.inset(
              circleRadius: circleRadius,
              outerInset: 40,
              thickness: 100,
              sweepAngle: 100.deg,
            ),
            decoration: GaugePartDecoration(color: AppColors.white1),
            child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
          ),
          GaugePart(
            shape: GaugePartRectShape.inset(
              circleRadius: circleRadius,
              width: 50,
              angle: -50.deg,
              innerInset: 20,
              outerInset: 70,
            ),
            decoration: GaugePartDecoration(color: AppColors.white1),
            child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
          ),
        ],
      ),
    );
  }
}
