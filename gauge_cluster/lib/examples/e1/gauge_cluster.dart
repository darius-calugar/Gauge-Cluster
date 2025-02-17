import 'package:flutter/material.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/examples/e1/fuel_gauge.dart';
import 'package:gauge_cluster/examples/e1/rev_gauge.dart';
import 'package:gauge_cluster/examples/e1/speed_gauge.dart';
import 'package:gauge_cluster/examples/e1/temperature_gauge.dart';
import 'package:gauge_cluster/utils/assets.dart';

class E1GaugeCluster extends StatelessWidget {
  const E1GaugeCluster({
    super.key,
    required this.currentSpeed,
    required this.currentRevs,
    required this.currentGear,
  });

  final double currentSpeed;
  final double currentRevs;
  final int currentGear;

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      clipper: _BackgroundClipper(),
      color: AppColors.black1,
      child: Stack(
        children: [
          Positioned.fill(
            right: null,
            child: E1RevGauge(
              currentRevs: currentRevs,
              currentGear: currentGear,
            ),
          ),
          Positioned.fill(
            left: null,
            child: E1SpeedGauge(
              currentSpeed: currentSpeed,
            ),
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
                color: AppColors.orange1,
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
                color: AppColors.orange1,
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
                color: AppColors.green1,
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
                color: AppColors.red1,
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
                color: AppColors.green1,
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
                color: AppColors.red1,
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
                color: AppColors.red1,
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
                color: AppColors.red1,
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
                color: AppColors.red1,
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
                color: AppColors.orange1,
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
