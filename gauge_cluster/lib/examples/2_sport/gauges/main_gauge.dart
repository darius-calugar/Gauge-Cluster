import 'package:flutter/material.dart';
import 'package:gauge_cluster/examples/e2/gear_bar.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_line.dart';
import 'package:gauge_cluster/utils/math/circle/circle_slice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';
import 'package:gauge_cluster/utils/math/units/rot_freq.dart';
import 'package:intl/intl.dart';

class SportMainGauge extends StatelessWidget {
  const SportMainGauge({super.key});

  static Circle circle = Circle(radius: 400);

  @override
  Widget build(BuildContext context) {
    final carState = context.watch<CarCubit>().state;

    final slice = CircleSlice(startAngle: -200.deg, endAngle: 20.deg);

    final fullStepInterval = 4;
    final stepCount =
        RotFreq.ratio(
          carState.maxRevs,
          RotFreq.unit / fullStepInterval,
        ).floor();
    final redlineStep =
        RotFreq.ratio(
          carState.maxRevs * carState.redlineRatio,
          RotFreq.unit / fullStepInterval,
        ).floor();
    final stepSweepAngle = slice.sweepAngle / stepCount;

    final redlineSlice = CircleSlice(
      startAngle: slice.startAngle + (slice.sweepAngle * carState.redlineRatio),
      endAngle: slice.endAngle,
    );

    final primaryColor =
        carState.revs < carState.redline - 250.rpm
            ? AppColors.blue5
            : carState.revs < carState.redline
            ? AppColors.green5
            : AppColors.red5;
    final secondaryColor =
        carState.revs < carState.redline - 250.rpm
            ? AppColors.blue8
            : carState.revs < carState.redline
            ? AppColors.green8
            : AppColors.red7;
    final tertiaryColor =
        carState.revs < carState.redline - 250.rpm
            ? AppColors.blue9
            : carState.revs < carState.redline
            ? AppColors.green9
            : AppColors.red9;

    return Gauge(
      circle: circle,
      parts: [
        // Backgrounds
        GaugePart(
          shape: GaugeSectorShape(outerRadius: 200),
          fill: GaugeRadialGradientFill(
            colors: [AppColors.black4, AppColors.black2],
            stops: [0.8, 1.0],
          ),
        ),
        GaugePart(
          shape: GaugeSectorShape(innerRadius: 200, outerRadius: 280),
          fill: GaugeRadialGradientFill(
            colors: [AppColors.black4, AppColors.black3],
          ),
        ),
        GaugePart(
          shape: GaugeSectorShape(innerRadius: 280, thickness: 40),
          fill: GaugeRadialGradientFill(
            colors: [AppColors.black5, AppColors.black4],
          ),
        ),

        // Fills
        GaugePart(
          shape: GaugeSectorShape(
            innerRadius: 280,
            thickness: 40,
            startAngle: redlineSlice.startAngle,
            endAngle: redlineSlice.endAngle,
          ),
          fill: GaugeRadialGradientFill(
            colors: [AppColors.red8, AppColors.red9],
          ),
        ),
        GaugePart(
          shape: GaugeSectorShape(
            innerRadius: 280,
            thickness: 40,
            startAngle: redlineSlice.startAngle - stepSweepAngle,
            endAngle: redlineSlice.startAngle,
          ),
          fill: GaugeRadialGradientFill(
            colors: [AppColors.green8, AppColors.green9],
          ),
        ),
        GaugePart(
          shape: GaugeSectorShape(
            innerRadius: 280,
            thickness: 40,
            startAngle: Angle.bottom,
            sweepAngle: Angle.top + slice.atRatio(carState.revsRatio),
          ),
          fill: GaugeRadialGradientFill(
            colors: [secondaryColor, tertiaryColor],
          ),
        ),

        // Outlines
        GaugePart(
          shape: GaugeSectorShape(innerRadius: 320, thickness: 4),
          fill: GaugeSolidFill(color: AppColors.white9),
        ),
        GaugePart(
          shape: GaugeSectorShape(innerRadius: 280 - 2, thickness: 2),
          fill: GaugeSolidFill(color: AppColors.white9),
        ),
        GaugePart(
          shape: GaugeSectorShape(innerRadius: 200, thickness: 2),
          fill: GaugeSolidFill(color: AppColors.black6),
        ),

        // Overlay
        GaugePart(
          shape: GaugeSectorShape(),
          fill: GaugeLinearGradientFill(
            line: CircleLine(start: circle.bottom, end: circle.top),
            colors: [AppColors.black3, AppColors.black3.withAlpha(0x00)],
            stops: [0.25, .8],
          ),
        ),

        for (var step = 0; step <= stepCount; step++)
          if (step % fullStepInterval == 0) ...[
            // Full Steps
            GaugePart(
              shape: GaugeRectShape(
                innerRadius: 280,
                thickness: 20,
                width: 4,
                angle: slice.atRatio(step / stepCount),
              ),
              fill: GaugeSolidFill(color: AppColors.white1),
            ),
            GaugePart(
              shape: GaugePointShape(
                radius: 250,
                angle: slice.atRatio(step / stepCount),
              ),
              child: Text(
                '${step ~/ fullStepInterval}',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 35),
              ),
            ),
          ] else
            // Steps
            GaugePart(
              shape: GaugeRectShape(
                innerRadius: 280,
                thickness: 10,
                width: 2,
                angle: slice.atRatio(step / stepCount),
              ),
              fill: GaugeSolidFill(
                color:
                    carState.revs >= (carState.maxRevs / stepCount) * step
                        ? primaryColor
                        : step < redlineStep
                        ? AppColors.white9
                        : AppColors.red7,
              ),
            ),

        // Marker
        GaugePart(
          shape: GaugeRectShape(
            innerRadius: 280 - 2,
            thickness: 40 + 2,
            width: 6,
            angle: slice.atRatio(carState.revsRatio),
          ),
          fill: GaugeSolidFill(color: primaryColor),
        ),
        GaugePart(
          shape: GaugeSectorShape(
            innerRadius: 280 - 2,
            thickness: 6,
            startAngle: slice.startAngle,
            endAngle: slice.atRatio(carState.revsRatio),
          ),
          fill: GaugeSolidFill(color: primaryColor),
        ),

        // Speed
        GaugePart(
          shape: GaugePointShape(radius: 50, angle: Angle.top),
          child: Text(
            '${carState.speed.toKmh.floor()}',
            style: TextStyle(fontSize: 100, fontWeight: FontWeight.w700),
          ),
        ),
        GaugePart(
          shape: GaugePointShape(radius: 20, angle: Angle.bottom),
          child: Text(
            'KM/H',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),

        // Gear
        GaugePart(
          shape: GaugePointShape(radius: 80, angle: Angle.bottom),
          child: E2GearBar(),
        ),

        // Time
        GaugePart(
          shape: GaugePointShape(radius: 230, angle: Angle.bottom),
          child: Text(
            DateFormat('HH:mm').format(DateTime.now()),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
        ),

        // Mileage
        GaugePart(
          shape: GaugePointShape(radius: 300, angle: Angle.bottom),
          child: Text(
            '${carState.mileage.toKm.floor()}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
          ),
        ),
        GaugePart(
          shape: GaugePointShape(radius: 320, angle: Angle.bottom),
          child: Text(
            'KM',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
          ),
        ),
      ],
    );
  }
}
