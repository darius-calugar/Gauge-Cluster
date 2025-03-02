import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge.dart';
import 'package:gauge_cluster/components/mileage/mileage.dart';
import 'package:gauge_cluster/examples/1_brawn/parts/pin_part.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_slice.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class BrawnSpeedGauge extends StatelessWidget {
  const BrawnSpeedGauge({super.key});

  static Circle circle = Circle(radius: 300);

  @override
  Widget build(BuildContext context) {
    final carState = context.watch<CarCubit>().state;

    final slice = CircleSlice(startAngle: -180.deg, endAngle: 30.deg);

    final outerSteps = carState.maxSpeed.toKmh ~/ 2 + 1;
    final outerStepAngleSweep = slice.sweepAngle / (outerSteps - 1);

    final innerSteps = carState.maxSpeed.toMph ~/ 10 + 1;
    final innerStepAngleSweep = slice.sweepAngle / (innerSteps - 1);

    return Gauge(
      circle: circle,
      parts: [
        // KMH
        GaugePart(
          shape: GaugePointShape.inset(
            outerInset: 45,
            angle: slice.endAngle + 10.deg,
          ),
          child: Text(
            'KM/H',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.white1,
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
            sweepAngle: slice.sweepAngle,
          ),
          fill: GaugeSolidFill(color: AppColors.white7),
        ),
        for (var step = 0; step < outerSteps; step++)
          if (step % 10 == 0) ...[
            // Steps
            GaugePart(
              shape: GaugeRectShape.inset(
                outerInset: 30,
                thickness: 16,
                width: 4,
                angle: slice.startAngle + outerStepAngleSweep * step,
              ),
              fill: GaugeLinearGradientFill(
                colors: [AppColors.white1, AppColors.white7],
              ),
            ),
            // Step labels
            GaugePart(
              shape: GaugePointShape.inset(
                outerInset: 60,
                angle: slice.startAngle + outerStepAngleSweep * step,
              ),
              isRotated: true,
              child: Text(
                '${step * 2}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.white1,
                ),
              ),
            ),
          ] else if (step % 5 == 0)
            // Half-steps
            GaugePart(
              shape: GaugeRectShape.inset(
                outerInset: 36,
                thickness: 6,
                width: 2,
                angle: slice.startAngle + outerStepAngleSweep * step,
              ),
              fill: GaugeSolidFill(color: AppColors.white1),
            )
          else
            // Quarter-steps
            GaugePart(
              shape: GaugeRectShape.inset(
                outerInset: 36,
                thickness: 2,
                width: 1,
                angle: slice.startAngle + outerStepAngleSweep * step,
              ),
              fill: GaugeSolidFill(color: AppColors.white1),
            ),

        // MPH
        GaugePart(
          shape: GaugePointShape.inset(
            outerInset: 100,
            angle: slice.endAngle + 10.deg,
          ),
          isRotated: false,
          child: Text(
            'MPH',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.white7,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        for (var step = 0; step < innerSteps; step++)
          if (step % 2 == 0) ...[
            // Steps
            GaugePart(
              shape: GaugeRectShape.inset(
                outerInset: 100,
                thickness: 8,
                width: 2,
                angle: slice.startAngle + innerStepAngleSweep * step,
              ),
              fill: GaugeSolidFill(color: AppColors.white7),
            ),
            // Step labels
            GaugePart(
              shape: GaugePointShape.inset(
                outerInset: 120,
                angle: slice.startAngle + innerStepAngleSweep * step,
              ),
              isRotated: true,
              child: Text(
                '${step * 10}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.white7,
                ),
              ),
            ),
          ] else
            // Half-steps
            GaugePart(
              shape: GaugeRectShape.inset(
                outerInset: 100,
                thickness: 4,
                width: 1,
                angle: slice.startAngle + innerStepAngleSweep * step,
              ),
              fill: GaugeSolidFill(color: AppColors.white7),
            ),

        // Mileage
        GaugePart(
          shape: GaugePointShape(radius: 50, angle: Angle.bottom),
          child: Mileage(distance: carState.mileage, digitCount: 6),
        ),

        // Pin
        PinPart(
          outerInset: 40,
          knobRadius: 16,
          angle: slice.atRatio(carState.speedRatio),
        ),
      ],
    );
  }
}
