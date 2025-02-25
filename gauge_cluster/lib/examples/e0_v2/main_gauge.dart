import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/utils/assets.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_line.dart';
import 'package:gauge_cluster/utils/math/circle/circle_slice.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class E0MainGauge extends StatelessWidget {
  const E0MainGauge({super.key});

  static Circle circle = Circle(radius: 400);

  @override
  Widget build(BuildContext context) {
    final uStepCount = 6;
    final vStepCount = 10;

    final uStep = Angle.full / uStepCount;
    final vStep = circle.radius / vStepCount;

    return SizedBox.square(
      dimension: circle.diameter,
      child: Gauge(
        parts: [
          for (var u = 0; u < uStepCount; u++) ...[
            for (var v = 0; v < vStepCount; v++) ...[
              GaugePart(
                shape: GaugePartSectorShape(
                  circle: circle,
                  innerRadius: vStep * v,
                  thickness: vStep,
                  startAngle: uStep * u,
                  sweepAngle: uStep,
                ),
                fill: GaugePartSweepGradientFill(
                  slice: CircleSlice.full(),
                  colors: [
                    Color.fromARGB(255, 0, (v / vStepCount * 255).toInt(), 0),
                    Color.fromARGB(255, 255, (v / vStepCount * 255).toInt(), 0),
                  ],
                ),
              ),
            ],
          ],
          // Points
          GaugePart(
            shape: GaugePartPointShape(radius: 200, angle: Angle.top),
            child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
          ),
          // Sectors
          GaugePart(
            shape: GaugePartSectorShape.inset(
              circle: circle,
              outerInset: 40,
              thickness: 80,
              sweepAngle: 60.deg,
            ),
            fill: GaugePartSolidFill(color: AppColors.white1),
            child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
          ),
          GaugePart(
            shape: GaugePartSectorShape.inset(
              circle: circle,
              outerInset: 40,
              thickness: 80,
              startAngle: 60.deg,
              sweepAngle: 60.deg,
            ),
            fill: GaugePartSweepGradientFill(
              colors: [AppColors.white1, AppColors.white3],
            ),
            child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
          ),
          GaugePart(
            shape: GaugePartSectorShape.inset(
              circle: circle,
              outerInset: 40,
              thickness: 80,
              startAngle: 120.deg,
              sweepAngle: 60.deg,
            ),
            fill: GaugePartLinearGradientFill(
              colors: [AppColors.white1, AppColors.white3],
            ),
            child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
          ),
          // Rects
          GaugePart(
            shape: GaugePartRectShape.inset(
              circle: circle,
              width: 100,
              angle: -30.deg,
              innerInset: 120,
              outerInset: 40,
            ),
            fill: GaugePartSolidFill(color: AppColors.white1),
            child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
          ),
          GaugePart(
            shape: GaugePartRectShape.inset(
              circle: circle,
              width: 100,
              angle: -90.deg,
              innerInset: 120,
              outerInset: 40,
            ),
            fill: GaugePartSweepGradientFill(
              colors: [AppColors.white1, AppColors.white3],
            ),
            child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
          ),
          GaugePart(
            shape: GaugePartRectShape.inset(
              circle: circle,
              width: 100,
              angle: -150.deg,
              innerInset: 120,
              outerInset: 40,
            ),
            fill: GaugePartLinearGradientFill(
              line: CircleLine(start: circle.top, end: circle.center),
              colors: [AppColors.white1, AppColors.white3],
            ),
            child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
          ),
        ],
      ),
    );
  }
}
