import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/examples/1_brawn/parts/pin_part.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_slice.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class BrawnRevGauge extends StatelessWidget {
  const BrawnRevGauge({super.key});

  static Circle circle = Circle(radius: 300);

  @override
  Widget build(BuildContext context) {
    final carState = context.watch<CarCubit>().state;

    final slice = CircleSlice(startAngle: -210.deg, endAngle: -50.deg);
    final redlineSlice = CircleSlice(
      startAngle: slice.atRatio(carState.redlineRatio),
      endAngle: -50.deg,
    );

    final steps = (carState.maxRevs.toRpm ~/ 100) + 1;
    final stepAngleSweep = slice.sweepAngle / (steps - 1);

    final redlineStep = carState.redline.toRpm ~/ 100;
    final redlineStepSnapped = (redlineStep / 10).round() * 10;

    return Gauge(
      circle: circle,
      parts: [
        // RPM legend
        GaugePart(
          shape: GaugePointShape.inset(outerInset: 100, angle: Angle.top),
          child: Text(
            'RPM x 1000',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.white.$9,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),

        // Border
        GaugePart(
          shape: GaugeSectorShape.inset(
            outerInset: 30,
            thickness: 2,
            startAngle: slice.startAngle,
            endAngle: redlineSlice.startAngle - stepAngleSweep / 2,
          ),
          fill: GaugeSolidFill(color: AppColors.white.$7),
        ),
        GaugePart(
          shape: GaugeSectorShape.inset(
            outerInset: 30,
            thickness: 2,
            startAngle: redlineSlice.startAngle,
            endAngle: redlineSlice.endAngle,
          ),
          fill: GaugeSolidFill(color: AppColors.darkRed.$4),
        ),

        for (var step = 0; step < steps; step++)
          if (step % 10 == 0) ...[
            // Steps
            GaugePart(
              shape: GaugeRectShape.inset(
                outerInset: 30,
                thickness: 16,
                width: 4,
                angle: slice.startAngle + stepAngleSweep * step,
              ),
              fill:
                  step < redlineStepSnapped
                      ? GaugeLinearGradientFill(
                        colors: [AppColors.white.$1, AppColors.white.$7],
                      )
                      : GaugeSolidFill(color: AppColors.darkRed.$4),
            ),
            // Step labels
            GaugePart(
              shape: GaugePointShape.inset(
                outerInset: 60,
                angle: slice.startAngle + stepAngleSweep * step,
              ),
              isRotated: true,
              child: Text(
                '${step ~/ 10}',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
          ] else if (step < redlineStepSnapped)
            // Quarter-steps
            GaugePart(
              shape: GaugeRectShape.inset(
                outerInset: 36,
                thickness: 2,
                width: 1,
                angle: slice.startAngle + stepAngleSweep * step,
              ),
              fill: GaugeSolidFill(color: AppColors.white.$1),
            )
          else
            // Redline Quarter-steps
            GaugePart(
              shape: GaugeRectShape.inset(
                outerInset: 34,
                thickness: 4,
                width: 2,
                angle: slice.startAngle + stepAngleSweep * step,
              ),
              fill: GaugeSolidFill(color: AppColors.darkRed.$4),
            ),

        // Gears
        for (var gear = carState.minGears; gear <= carState.maxGears; gear++)
          GaugePart(
            shape: GaugePointShape.inset(
              outerInset: 15,
              angle: 145.deg + 8.deg * (gear + 1),
            ),
            child: Text(
              switch (gear) {
                < 0 => 'R',
                0 => 'N',
                _ => '$gear',
              },
              style: TextStyle(
                color:
                    gear == carState.gear ? AppColors.red : AppColors.black.$4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

        // Pin
        PinPart(
          outerInset: 40,
          knobRadius: 16,
          angle: slice.atRatio(carState.revsRatio),
        ),
      ],
    );
  }
}
