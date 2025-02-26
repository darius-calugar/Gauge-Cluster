import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge.dart';
import 'package:gauge_cluster/components/mileage/mileage.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class BrawnSpeedGauge extends StatelessWidget {
  const BrawnSpeedGauge({super.key});

  static Circle circle = Circle(radius: 300);

  @override
  Widget build(BuildContext context) {
    final carState = context.watch<CarCubit>().state;

    final startAngle = -180.0.deg;
    final endAngle = 30.0.deg;
    final sweepAngle = endAngle - startAngle;

    final outerSteps = carState.maxSpeed.toKmh ~/ 2 + 1;
    final outerStepAngleSweep = sweepAngle / (outerSteps - 1);

    final innerSteps = carState.maxSpeed.toMph ~/ 10 + 1;
    final innerStepAngleSweep = sweepAngle / (innerSteps - 1);

    return Gauge(
      circle: circle,
      parts: [
        // KMH
        GaugePart(
          shape: GaugePartPointShape(
            radius: circle.radius - 45,
            angle: endAngle + 10.deg,
          ),
          isRotated: false,
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
          shape: GaugePartSectorShape.inset(
            outerInset: 30,
            thickness: 2,
            startAngle: startAngle,
            sweepAngle: sweepAngle,
          ),
          fill: GaugePartSolidFill(color: AppColors.white2),
        ),
        for (var step = 0; step < outerSteps; step++)
          if (step % 10 == 0) ...[
            // Steps
            GaugePart(
              shape: GaugePartRectShape.inset(
                outerInset: 30,
                thickness: 16,
                width: 4,
                angle: startAngle + outerStepAngleSweep * step,
              ),
              fill: GaugePartLinearGradientFill(
                colors: [AppColors.white1, AppColors.white2],
              ),
            ),
            // Step labels
            GaugePart(
              shape: GaugePartPointShape(
                radius: circle.radius - 60,
                angle: startAngle + outerStepAngleSweep * step,
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
              shape: GaugePartRectShape.inset(
                outerInset: 36,
                thickness: 6,
                width: 2,
                angle: startAngle + outerStepAngleSweep * step,
              ),
              fill: GaugePartSolidFill(color: AppColors.white1),
            )
          else
            // Quarter-steps
            GaugePart(
              shape: GaugePartRectShape.inset(
                outerInset: 36,
                thickness: 2,
                width: 1,
                angle: startAngle + outerStepAngleSweep * step,
              ),
              fill: GaugePartSolidFill(color: AppColors.white1),
            ),

        // MPH
        GaugePart(
          shape: GaugePartPointShape(
            radius: circle.radius - 100,
            angle: endAngle + 10.deg,
          ),
          isRotated: false,
          child: Text(
            'MPH',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.white1,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        for (var step = 0; step < innerSteps; step++)
          if (step % 2 == 0) ...[
            // Steps
            GaugePart(
              shape: GaugePartRectShape.inset(
                outerInset: 100,
                thickness: 8,
                width: 2,
                angle: startAngle + innerStepAngleSweep * step,
              ),
              fill: GaugePartSolidFill(color: AppColors.white2),
            ),
            // Step labels
            GaugePart(
              shape: GaugePartPointShape(
                radius: circle.radius - 120,
                angle: startAngle + innerStepAngleSweep * step,
              ),
              isRotated: true,
              child: Text(
                '${step * 10}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.white2,
                ),
              ),
            ),
          ] else
            // Half-steps
            GaugePart(
              shape: GaugePartRectShape.inset(
                outerInset: 100,
                thickness: 4,
                width: 1,
                angle: startAngle + innerStepAngleSweep * step,
              ),
              fill: GaugePartSolidFill(color: AppColors.white2),
            ),

        // Mileage
        GaugePart(
          shape: GaugePartPointShape(radius: 50, angle: Angle.bottom),
          child: Mileage(distance: carState.mileage, digitCount: 6),
        ),

        // Knob base
        GaugePart(
          shape: GaugePartSectorShape(outerRadius: 20),
          fill: GaugePartSolidFill(color: AppColors.black2),
        ),
        // Pin
        GaugePart(
          shape: GaugePartRectShape.inset(
            width: 3,
            outerInset: 40,
            angle: Angle.lerp(startAngle, endAngle, carState.speedRatio),
          ),
          fill: GaugePartSolidFill(color: AppColors.red1),
        ),
        // Knob
        GaugePart(
          shape: GaugePartSectorShape(outerRadius: 16),
          fill: GaugePartSolidFill(color: AppColors.black3),
        ),
      ],
    );
  }
}
