import 'package:flutter/material.dart';
import 'package:gauge_cluster/utils/app_colors.dart';

part 'mileage_digit.dart';

class Mileage extends StatelessWidget {
  const Mileage({super.key, required this.value, required this.digitCount});

  final int value;
  final int digitCount;

  @override
  Widget build(BuildContext context) {
    final digits =
        [
          for (
            var i = 0, loopValue = value;
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
