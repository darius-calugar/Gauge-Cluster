import 'package:flutter/material.dart';
import 'package:gauge_cluster/utils/app_colors.dart';

class DebugColorPallette extends StatelessWidget {
  DebugColorPallette({super.key});

  final colors = [
    AppColors.black.values,
    AppColors.white.values,
    [
      ...AppColors.lightRed.values.reversed,
      AppColors.red,
      ...AppColors.darkRed.values,
    ],
    [
      ...AppColors.lightOrange.values.reversed,
      AppColors.orange,
      ...AppColors.darkOrange.values,
    ],
    [
      ...AppColors.lightYellow.values.reversed,
      AppColors.yellow,
      ...AppColors.darkYellow.values,
    ],
    [
      ...AppColors.lightGreen.values.reversed,
      AppColors.green,
      ...AppColors.darkGreen.values,
    ],
    [
      ...AppColors.lightCyan.values.reversed,
      AppColors.cyan,
      ...AppColors.darkCyan.values,
    ],
    [
      ...AppColors.lightBlue.values.reversed,
      AppColors.blue,
      ...AppColors.darkBlue.values,
    ],
    [
      ...AppColors.lightPurple.values.reversed,
      AppColors.purple,
      ...AppColors.darkPurple.values,
    ],
    [
      ...AppColors.lightPink.values.reversed,
      AppColors.pink,
      ...AppColors.darkPink.values,
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var row in colors) ...[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var color in row) ...[
                  Expanded(
                    child: Transform.scale(
                      scale: 1.05,
                      child: Container(color: color),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
