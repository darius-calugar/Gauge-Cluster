import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/utils/assets.dart';
import 'package:gauge_cluster/utils/math/circle/circle_slice.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class E0MainGauge extends StatelessWidget {
  const E0MainGauge({super.key});

  static double circleRadius = 400.0;

  @override
  Widget build(BuildContext context) {
    final uStepCount = 10;
    final vStepCount = 10;

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
                decoration: GaugePartSweepGradientDecoration(
                  slice: CircleSlice.full(),
                  colors: [
                    Color.fromARGB(255, 0, (v / vStepCount * 255).toInt(), 0),
                    Color.fromARGB(255, 255, (v / vStepCount * 255).toInt(), 0),
                  ],
                ),
              ),
            ],
          ],
          GaugePart(
            shape: GaugePartPointShape(radius: 200, angle: Angle.up),
            child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
          ),
          GaugePart(
            shape: GaugePartSectorShape.inset(
              circleRadius: circleRadius,
              outerInset: 40,
              thickness: 100,
              sweepAngle: 100.deg,
            ),
            decoration: GaugePartSweepGradientDecoration(
              colors: [AppColors.white1, AppColors.white3],
            ),
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
            decoration: GaugePartSweepGradientDecoration(
              colors: [AppColors.white1, AppColors.white3],
            ),
            child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
          ),
        ],
      ),
    );
  }
}
