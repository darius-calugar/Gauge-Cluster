import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/blocs/car_cubit.dart';
import 'package:gauge_cluster/components/toggle/toggle.dart';
import 'package:gauge_cluster/examples/e2/gauge_cluster.dart';
import 'package:gauge_cluster/utils/assets.dart';

class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({super.key});

  @override
  State<PlaygroundScreen> createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
  @override
  Widget build(BuildContext context) {
    final carCubit = context.watch<CarCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            color: AppColors.black2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: FittedBox(
                child: SizedBox(
                  width: 800,
                  height: 600,
                  child: E2GaugeCluster(),
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          color: AppColors.black1,
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Slider(
                  max: carCubit.state.maxSpeed,
                  value: carCubit.state.speed,
                  onChanged: carCubit.setSpeed,
                ),
                Slider(
                  max: carCubit.state.maxRevs,
                  value: carCubit.state.revs,
                  onChanged: carCubit.setRevs,
                ),
                Slider(
                  max: 999999,
                  value: carCubit.state.mileage.toDouble(),
                  onChanged: (mileage) => carCubit.setMileage(mileage.round()),
                ),
                Slider(
                  min: carCubit.state.minGears.toDouble(),
                  max: carCubit.state.maxGears.toDouble(),
                  divisions: carCubit.state.maxGears - carCubit.state.minGears,
                  value: carCubit.state.gear.toDouble(),
                  onChanged: (gear) => carCubit.shiftTo(gear.round()),
                ),
                Slider(value: carCubit.state.fuel, onChanged: carCubit.setFuel),
                Slider(
                  value: carCubit.state.temperature,
                  onChanged: carCubit.setTemperature,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Toggle(
                      icon: SvgIcons.left,
                      value: carCubit.state.leftTurnSignal,
                      onTap: carCubit.toggleLeftTurnSignal,
                    ),
                    Toggle(
                      icon: SvgIcons.right,
                      value: carCubit.state.rightTurnSignal,
                      onTap: carCubit.toggleRightTurnSignal,
                    ),
                    Toggle(
                      icon: SvgIcons.doors,
                      value: carCubit.state.doorSignal,
                      onTap: carCubit.toggleDoorSignal,
                    ),
                    Toggle(
                      icon: SvgIcons.brakes,
                      value: carCubit.state.brakesSignal,
                      onTap: carCubit.toggleBrakesSignal,
                    ),
                    Toggle(
                      icon: SvgIcons.battery,
                      value: carCubit.state.batterySignal,
                      onTap: carCubit.toggleBatterySignal,
                    ),
                    Toggle(
                      icon: SvgIcons.transmission,
                      value: carCubit.state.transmissionSignal,
                      onTap: carCubit.toggleTransmissionSignal,
                    ),
                    Toggle(
                      icon: SvgIcons.engine,
                      value: carCubit.state.engineSignal,
                      onTap: carCubit.toggleEngineSignal,
                    ),
                    Toggle(
                      icon: SvgIcons.wrench,
                      value: carCubit.state.serviceSignal,
                      onTap: carCubit.toggleServiceSignal,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
