import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/utils/app_colors.dart';

class E2GearBar extends StatelessWidget {
  const E2GearBar({super.key});

  @override
  Widget build(BuildContext context) {
    final carState = context.watch<CarCubit>().state;

    return Row(
      // spacing: 24,
      children: [
        for (
          var gear = carState.minGears - 1;
          gear <= carState.maxGears + 1;
          gear++
        )
          AnimatedSwitcher(
            duration: Durations.short3,
            transitionBuilder:
                (child, animation) => SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                  child: FadeTransition(opacity: animation, child: child),
                ),
            child:
                (gear - carState.gear).abs() <= 1
                    ? Container(
                      key: ValueKey(gear),
                      width: 40,
                      alignment: Alignment.center,
                      child: AnimatedDefaultTextStyle(
                        duration: Durations.short3,
                        curve: Curves.ease,
                        style:
                            gear == carState.gear
                                ? TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white1,
                                )
                                : TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.white9,
                                ),
                        child:
                            gear >= carState.minGears &&
                                    gear <= carState.maxGears
                                ? Text(switch (gear) {
                                  -1 => 'R',
                                  0 => 'N',
                                  _ => '$gear',
                                })
                                : SizedBox.shrink(),
                      ),
                    )
                    : SizedBox.shrink(),
          ),
      ],
    );
  }
}
