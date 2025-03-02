import 'package:flutter/material.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/examples/1_brawn/parts/pin_part.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge.dart';
import 'package:gauge_cluster/utils/assets.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_slice.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class BrawnAuxGauge extends StatelessWidget {
  const BrawnAuxGauge({
    super.key,
    required this.ratio,
    required this.icon,
    required this.lowText,
    required this.highText,
    this.isLowDanger = false,
    this.isHighDanger = false,
  });

  final double ratio;
  final SvgIconData icon;
  final String lowText;
  final String highText;
  final bool isLowDanger;
  final bool isHighDanger;

  static Circle circle = Circle(radius: 70);

  @override
  Widget build(BuildContext context) {
    final slice = CircleSlice(startAngle: 160.deg, endAngle: 280.deg);
    final fullSlice = CircleSlice(
      startAngle: slice.startAngle - 8.deg,
      endAngle: slice.endAngle + 8.deg,
    );

    return Gauge(
      circle: circle,
      parts: [
        // Border
        GaugePart(
          shape: GaugeSectorShape.inset(
            outerInset: 0,
            thickness: 2,
            startAngle: slice.startAngle,
            sweepAngle: slice.sweepAngle,
          ),
          fill: GaugeSolidFill(color: AppColors.white.$1),
        ),

        for (var step = 0; step < 5; step++) ...[
          // Steps
          GaugePart(
            shape: GaugeRectShape.inset(
              outerInset: 0,
              thickness: 8,
              width: 2,
              angle: 160.deg + 30.deg * step.toDouble(),
            ),
            fill: GaugeSolidFill(color: AppColors.white.$1),
          ),
        ],

        // Limits
        GaugePart(
          shape: GaugeSectorShape.inset(
            outerInset: 0,
            thickness: 12,
            endAngle: slice.startAngle - 4.deg,
            sweepAngle: 8.deg,
          ),
          fill: GaugeSolidFill(
            color: isLowDanger ? AppColors.darkRed.$6 : AppColors.white.$1,
          ),
        ),
        GaugePart(
          shape: GaugeSectorShape.inset(
            outerInset: 0,
            thickness: 12,
            startAngle: slice.endAngle + 4.deg,
            sweepAngle: 8.deg,
          ),
          fill: GaugeSolidFill(
            color: isHighDanger ? AppColors.darkRed.$6 : AppColors.white.$1,
          ),
        ),

        // Labels
        GaugePart(
          shape: GaugePointShape.inset(
            outerInset: 24,
            angle: slice.startAngle - 5.deg,
          ),
          child: Text(
            lowText,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
        ),
        GaugePart(
          shape: GaugePointShape.inset(
            outerInset: 24,
            angle: slice.endAngle + 5.deg,
          ),
          child: Text(
            highText,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
        ),

        // Icon
        GaugePart(
          shape: GaugePointShape.inset(innerInset: 40, angle: slice.midAngle),
          child: SvgIcon(icon, color: AppColors.white.$1, size: 24),
        ),

        // Pin
        PinPart(outerInset: 5, knobRadius: 10, angle: fullSlice.atRatio(ratio)),
      ],
    );
  }
}
