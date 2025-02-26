import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/utils/assets.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_slice.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class DebugMainGauge extends StatelessWidget {
  const DebugMainGauge({super.key});

  static Circle circle = Circle(radius: 400);

  @override
  Widget build(BuildContext context) {
    final uStepCount = 6;
    final vStepCount = 10;

    final uStep = Angle.full / uStepCount;
    final vStep = circle.radius / vStepCount;

    return Gauge(
      circle: circle,
      parts: [
        for (var u = 0; u < uStepCount; u++) ...[
          for (var v = 0; v < vStepCount; v++) ...[
            GaugePart(
              shape: GaugePartSectorShape(
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
        for (var u = 0; u < uStepCount; u++) ...[
          GaugePart(
            shape: GaugePartPointShape(radius: 60, angle: 30.deg + 60.deg * u),
            isRotated: true,
            child: SvgIcon(SvgIcons.battery, color: AppColors.white1),
          ),
        ],
        GaugePart(
          shape: GaugePartPointShape(radius: 140, angle: 90.deg),
          isRotated: false,
          child: SvgIcon(SvgIcons.battery, color: AppColors.white1),
        ),
        // Sectors
        GaugePart(
          shape: GaugePartSectorShape.inset(
            outerInset: 40,
            thickness: 80,
            startAngle: 0.deg,
            sweepAngle: 60.deg,
          ),
          fill: GaugePartSweepGradientFill(
            colors: [AppColors.white1, AppColors.black1],
          ),
          isRotated: true,
          child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
        ),
        GaugePart(
          shape: GaugePartSectorShape.inset(
            outerInset: 40,
            thickness: 80,
            startAngle: 60.deg,
            sweepAngle: 60.deg,
          ),
          fill: GaugePartLinearGradientFill(
            colors: [AppColors.white1, AppColors.black1],
          ),
          isRotated: true,
          child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
        ),
        GaugePart(
          shape: GaugePartSectorShape.inset(
            outerInset: 40,
            thickness: 80,
            startAngle: 120.deg,
            sweepAngle: 60.deg,
          ),
          fill: GaugePartRadialGradientFill(
            colors: [AppColors.white1, AppColors.black1],
          ),
          isRotated: true,
          child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
        ),
        // Rects
        GaugePart(
          shape: GaugePartRectShape.inset(
            width: 100,
            angle: -30.deg,
            innerInset: 120,
            outerInset: 40,
          ),
          fill: GaugePartSweepGradientFill(
            colors: [AppColors.white1, AppColors.black1],
          ),
          isRotated: true,
          child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
        ),
        GaugePart(
          shape: GaugePartRectShape.inset(
            width: 100,
            angle: -90.deg,
            innerInset: 120,
            outerInset: 40,
          ),
          fill: GaugePartLinearGradientFill(
            colors: [AppColors.white1, AppColors.black1],
          ),
          isRotated: true,
          child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
        ),
        GaugePart(
          shape: GaugePartRectShape.inset(
            width: 100,
            angle: -150.deg,
            innerInset: 120,
            outerInset: 40,
          ),
          fill: GaugePartRadialGradientFill(
            colors: [AppColors.white1, AppColors.black1],
          ),
          isRotated: true,
          child: SvgIcon(SvgIcons.battery, color: AppColors.black1),
        ),
      ],
    );
  }
}
