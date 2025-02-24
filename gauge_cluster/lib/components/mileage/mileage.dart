import 'package:flutter/material.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/utils/math/units/distance.dart';

part 'mileage_digit.dart';

class Mileage extends StatelessWidget {
  const Mileage({super.key, required this.distance, required this.digitCount});

  final Distance distance;
  final int digitCount;

  @override
  Widget build(BuildContext context) {
    final digits =
        [
          for (
            var i = 0, loopValue = distance.toKm.toInt();
            i < digitCount;
            i++, loopValue ~/= 10
          )
            loopValue % 10,
        ].reversed;

    return Row(
      spacing: 3,
      mainAxisSize: MainAxisSize.min,
      children: [for (final digit in digits) MileageDigit(digit: digit)],
    );
  }
}
