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
              shape: GaugeSectorShape(
                innerRadius: vStep * v,
                thickness: vStep,
                startAngle: uStep * u,
                sweepAngle: uStep,
              ),
              fill: GaugeSweepGradientFill(
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
            shape: GaugePointShape(radius: 60, angle: 30.deg + 60.deg * u),
            isRotated: true,
            child: SvgIcon(SvgIcons.battery, color: AppColors.white.$1),
          ),
        ],
        GaugePart(
          shape: GaugePointShape(radius: 140, angle: 90.deg),
          isRotated: false,
          child: SvgIcon(SvgIcons.battery, color: AppColors.white.$1),
        ),
        // Sectors
        GaugePart(
          shape: GaugeSectorShape.inset(
            outerInset: 40,
            thickness: 80,
            startAngle: 0.deg,
            sweepAngle: 60.deg,
          ),
          fill: GaugeSweepGradientFill(
            colors: [AppColors.white.$1, AppColors.black.$1],
          ),
          isRotated: true,
          child: SvgIcon(SvgIcons.battery, color: AppColors.black.$1),
        ),
        GaugePart(
          shape: GaugeSectorShape.inset(
            outerInset: 40,
            thickness: 80,
            startAngle: 60.deg,
            sweepAngle: 60.deg,
          ),
          fill: GaugeLinearGradientFill(
            colors: [AppColors.white.$1, AppColors.black.$1],
          ),
          isRotated: true,
          child: SvgIcon(SvgIcons.battery, color: AppColors.black.$1),
        ),
        GaugePart(
          shape: GaugeSectorShape.inset(
            outerInset: 40,
            thickness: 80,
            startAngle: 120.deg,
            sweepAngle: 60.deg,
          ),
          fill: GaugeRadialGradientFill(
            colors: [AppColors.white.$1, AppColors.black.$1],
          ),
          isRotated: true,
          child: SvgIcon(SvgIcons.battery, color: AppColors.black.$1),
        ),
        // Rects
        GaugePart(
          shape: GaugeRectShape.inset(
            width: 100,
            angle: -30.deg,
            innerInset: 200,
            outerInset: 40,
          ),
          fill: GaugeSweepGradientFill(
            colors: [AppColors.white.$1, AppColors.black.$1],
          ),
          isRotated: true,
          child: SvgIcon(SvgIcons.battery, color: AppColors.black.$1),
        ),
        GaugePart(
          shape: GaugeRectShape.inset(
            width: 100,
            angle: -90.deg,
            innerInset: 200,
            outerInset: 40,
          ),
          fill: GaugeLinearGradientFill(
            colors: [AppColors.white.$1, AppColors.black.$1],
          ),
          isRotated: true,
          child: SvgIcon(SvgIcons.battery, color: AppColors.black.$1),
        ),
        GaugePart(
          shape: GaugeRectShape.inset(
            width: 100,
            angle: -150.deg,
            innerInset: 200,
            outerInset: 40,
          ),
          fill: GaugeRadialGradientFill(
            colors: [AppColors.white.$1, AppColors.black.$1],
          ),
          isRotated: true,
          child: SvgIcon(SvgIcons.battery, color: AppColors.black.$1),
        ),
      ],
    );
  }
}
