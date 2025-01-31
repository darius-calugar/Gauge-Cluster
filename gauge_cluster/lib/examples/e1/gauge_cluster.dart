import 'package:flutter/material.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/examples/e1/fuel_gauge.dart';
import 'package:gauge_cluster/examples/e1/rev_gauge.dart';
import 'package:gauge_cluster/examples/e1/speed_gauge.dart';
import 'package:gauge_cluster/math.dart';

class E1GaugeCluster extends StatelessWidget {
  const E1GaugeCluster({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: ShapeDecoration(
                color: AppColors.black1,
                shape: CircleBorder(),
              ),
              child: E1FuelGauge(),
            ),
            Container(
              decoration: ShapeDecoration(
                color: AppColors.black1,
                shape: CircleBorder(),
              ),
              child: E1FuelGauge(),
            ),
          ],
        ),
        ClipPath(
          clipper: _BackgroundClipper(),
          child: Container(
            width: 650,
            height: 400,
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
              ],
            ),
          ),
        ),
        Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: ShapeDecoration(
                color: AppColors.black1,
                shape: CircleBorder(),
              ),
              child: E1FuelGauge(),
            ),
            Container(
              decoration: ShapeDecoration(
                color: AppColors.black1,
                shape: CircleBorder(),
              ),
              child: E1FuelGauge(),
            ),
          ],
        ),
      ],
    );
  }
}

class _BackgroundClipper extends CustomClipper<Path> {
  const _BackgroundClipper();

  @override
  bool shouldReclip(covariant _BackgroundClipper oldClipper) => true;

  @override
  Path getClip(Size size) {
    final gauge1Rect = Offset(0, 0) & Size.square(400);
    final gauge2Rect = Offset(250, 0) & Size.square(400);

    return Path()
      ..arcTo(gauge1Rect, 140 * toRadians, 165 * toRadians, false)
      ..arcTo(gauge2Rect, -125 * toRadians, 165 * toRadians, false);
  }
}
