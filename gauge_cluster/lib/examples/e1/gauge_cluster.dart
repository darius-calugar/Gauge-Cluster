import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/blocs/car_cubit.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/examples/e1/fuel_gauge.dart';
import 'package:gauge_cluster/examples/e1/rev_gauge.dart';
import 'package:gauge_cluster/examples/e1/speed_gauge.dart';
import 'package:gauge_cluster/examples/e1/temperature_gauge.dart';
import 'package:gauge_cluster/utils/assets.dart';

class E1GaugeCluster extends StatelessWidget {
  const E1GaugeCluster({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final carState = context.watch<CarCubit>().state;

    return PhysicalShape(
      clipper: _BackgroundClipper(),
      color: AppColors.black1,
      child: Stack(
        children: [
          Positioned.fill(
            right: null,
            child: E1RevGauge(),
          ),
          Positioned.fill(
            left: null,
            child: E1SpeedGauge(),
          ),
          Positioned(
            bottom: 120,
            left: 130,
            child: E1FuelGauge(),
          ),
          Positioned(
            bottom: 120,
            left: 250,
            child: E1TemperatureGauge(),
          ),
          Positioned(
            bottom: 210,
            right: 400,
            child: SizedOverflowBox(
              size: Size.zero,
              child: SvgIcon(
                SvgIcons.doors,
                color:
                    carState.doorSignal ? AppColors.orange1 : AppColors.black3,
              ),
            ),
          ),
          Positioned(
            bottom: 210,
            right: 350,
            child: SizedOverflowBox(
              size: Size.zero,
              child: SvgIcon(
                SvgIcons.battery,
                color: carState.batterySignal
                    ? AppColors.orange1
                    : AppColors.black3,
              ),
            ),
          ),
          Positioned(
            bottom: 210,
            right: 300,
            child: SizedOverflowBox(
              size: Size.zero,
              child: SvgIcon(
                SvgIcons.left,
                color: carState.leftTurnSignal
                    ? AppColors.green1
                    : AppColors.black3,
              ),
            ),
          ),
          Positioned(
            bottom: 210,
            right: 250,
            child: SizedOverflowBox(
              size: Size.zero,
              child: SvgIcon(
                SvgIcons.brakes,
                color:
                    carState.brakesSignal ? AppColors.red1 : AppColors.black3,
              ),
            ),
          ),
          Positioned(
            bottom: 210,
            right: 200,
            child: SizedOverflowBox(
              size: Size.zero,
              child: SvgIcon(
                SvgIcons.right,
                color: carState.rightTurnSignal
                    ? AppColors.green1
                    : AppColors.black3,
              ),
            ),
          ),
          Positioned(
            bottom: 170,
            right: 400,
            child: SizedOverflowBox(
              size: Size.zero,
              child: SvgIcon(
                SvgIcons.fuel,
                color: carState.fuelSignal ? AppColors.red1 : AppColors.black3,
              ),
            ),
          ),
          Positioned(
            bottom: 170,
            right: 350,
            child: SizedOverflowBox(
              size: Size.zero,
              child: SvgIcon(
                SvgIcons.temperature,
                color: carState.temperatureSignal
                    ? AppColors.red1
                    : AppColors.black3,
              ),
            ),
          ),
          Positioned(
            bottom: 170,
            right: 300,
            child: SizedOverflowBox(
              size: Size.zero,
              child: SvgIcon(
                SvgIcons.transmission,
                color: carState.transmissionSignal
                    ? AppColors.red1
                    : AppColors.black3,
              ),
            ),
          ),
          Positioned(
            bottom: 170,
            right: 250,
            child: SizedOverflowBox(
              size: Size.zero,
              child: SvgIcon(
                SvgIcons.wrench,
                color:
                    carState.serviceSignal ? AppColors.red1 : AppColors.black3,
              ),
            ),
          ),
          Positioned(
            bottom: 170,
            right: 200,
            child: SizedOverflowBox(
              size: Size.zero,
              child: SvgIcon(
                SvgIcons.engine,
                color: carState.engineSignal
                    ? AppColors.orange1
                    : AppColors.black3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundClipper extends CustomClipper<Path> {
  const _BackgroundClipper();

  @override
  bool shouldReclip(covariant _BackgroundClipper oldClipper) => true;

  @override
  Path getClip(Size size) {
    final safeRect = Offset(0, 0) & Size(800, 470);
    final gauge1Rect = Offset(0, 50) & Size.square(500);
    final gauge2Rect = Offset(300, 50) & Size.square(500);

    return Path.combine(
      PathOperation.intersect,
      Path()..addRect(safeRect),
      Path()
        ..addOval(gauge1Rect)
        ..addOval(gauge2Rect),
    );
  }
}
