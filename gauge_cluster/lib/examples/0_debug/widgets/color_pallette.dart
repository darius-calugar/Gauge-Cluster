import 'package:flutter/material.dart';
import 'package:gauge_cluster/utils/app_colors.dart';

class DebugColorPallette extends StatelessWidget {
  DebugColorPallette({super.key});

  final colors = [
    [
      AppColors.black1,
      AppColors.black2,
      AppColors.black3,
      AppColors.black4,
      AppColors.black5,
      AppColors.black6,
      AppColors.black7,
      AppColors.black8,
      AppColors.black9,
    ],
    [
      AppColors.white1,
      AppColors.white2,
      AppColors.white3,
      AppColors.white4,
      AppColors.white5,
      AppColors.white6,
      AppColors.white7,
      AppColors.white8,
      AppColors.white9,
    ],
    [
      AppColors.red1,
      AppColors.red2,
      AppColors.red3,
      AppColors.red4,
      AppColors.red5,
      AppColors.red6,
      AppColors.red7,
      AppColors.red8,
      AppColors.red9,
    ],
    [
      AppColors.orange1,
      AppColors.orange2,
      AppColors.orange3,
      AppColors.orange4,
      AppColors.orange5,
      AppColors.orange6,
      AppColors.orange7,
      AppColors.orange8,
      AppColors.orange9,
    ],
    [
      AppColors.yellow1,
      AppColors.yellow2,
      AppColors.yellow3,
      AppColors.yellow4,
      AppColors.yellow5,
      AppColors.yellow6,
      AppColors.yellow7,
      AppColors.yellow8,
      AppColors.yellow9,
    ],
    [
      AppColors.green1,
      AppColors.green2,
      AppColors.green3,
      AppColors.green4,
      AppColors.green5,
      AppColors.green6,
      AppColors.green7,
      AppColors.green8,
      AppColors.green9,
    ],
    [
      AppColors.cyan1,
      AppColors.cyan2,
      AppColors.cyan3,
      AppColors.cyan4,
      AppColors.cyan5,
      AppColors.cyan6,
      AppColors.cyan7,
      AppColors.cyan8,
      AppColors.cyan9,
    ],
    [
      AppColors.blue1,
      AppColors.blue2,
      AppColors.blue3,
      AppColors.blue4,
      AppColors.blue5,
      AppColors.blue6,
      AppColors.blue7,
      AppColors.blue8,
      AppColors.blue9,
    ],
    [
      AppColors.purple1,
      AppColors.purple2,
      AppColors.purple3,
      AppColors.purple4,
      AppColors.purple5,
      AppColors.purple6,
      AppColors.purple7,
      AppColors.purple8,
      AppColors.purple9,
    ],
    [
      AppColors.pink1,
      AppColors.pink2,
      AppColors.pink3,
      AppColors.pink4,
      AppColors.pink5,
      AppColors.pink6,
      AppColors.pink7,
      AppColors.pink8,
      AppColors.pink9,
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
                  Expanded(child: Container(color: color)),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
