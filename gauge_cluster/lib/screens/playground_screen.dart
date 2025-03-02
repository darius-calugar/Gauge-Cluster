import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/blocs/playground/playground_cubit.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/examples/0_debug/gauge_cluster.dart';
import 'package:gauge_cluster/examples/1_brawn/gauge_cluster.dart';
import 'package:gauge_cluster/examples/2_sport/gauge_cluster.dart';
import 'package:gauge_cluster/examples/e2/gauge_cluster.dart';
import 'package:gauge_cluster/utils/assets.dart';
import 'package:gauge_cluster/utils/math/units/distance.dart';
import 'package:gauge_cluster/utils/math/units/rot_freq.dart';
import 'package:gauge_cluster/utils/math/units/speed.dart';

class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({super.key});

  @override
  State<PlaygroundScreen> createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final playgroundCubit = context.watch<PlaygroundCubit>();
    final carCubit = context.watch<CarCubit>();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Material(
                  color: theme.colorScheme.surfaceContainerLow,
                  child: InkResponse(
                    highlightShape: BoxShape.rectangle,
                    onTap: playgroundCubit.setPreviousExample,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgIcon(SvgIcons.left),
                    ),
                  ),
                ),
                VerticalDivider(width: 2),
                Expanded(
                  child: Material(
                    color: theme.colorScheme.surface,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: AnimatedSwitcher(
                        duration: Durations.medium1,
                        transitionBuilder:
                            (child, animation) => FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                        child: SizedBox.expand(
                          key: ValueKey(playgroundCubit.state.example),
                          child: FittedBox(
                            child: switch (playgroundCubit.state) {
                              PlaygroundState(example: 0) =>
                                DebugGaugeCluster(),
                              PlaygroundState(example: 1) =>
                                BrawnGaugeCluster(),
                              PlaygroundState(example: 2) =>
                                SportGaugeCluster(),
                              PlaygroundState(example: 3) => E2GaugeCluster(),
                              _ => SizedBox.shrink(),
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalDivider(width: 2),
                Material(
                  color: theme.colorScheme.surfaceContainerLow,
                  child: InkResponse(
                    highlightShape: BoxShape.rectangle,
                    onTap: playgroundCubit.setNextExample,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgIcon(SvgIcons.right),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 2),
          Material(
            color: theme.colorScheme.surfaceContainerLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Material(
                  color: theme.colorScheme.surfaceContainerLow,
                  child: InkResponse(
                    highlightShape: BoxShape.rectangle,
                    onTap: playgroundCubit.toggleControls,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgIcon(SvgIcons.wrench),
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: Durations.medium1,
                  curve: Curves.ease,
                  child:
                      playgroundCubit.state.areControlsExpanded
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _Slider(
                                  name: 'Max Speed (km/h)',
                                  min: Speed.unit.toKmh,
                                  max: Speed.unit.toKmh * 20,
                                  divisions: 19,
                                  value: carCubit.state.maxSpeed.toKmh,
                                  onChanged:
                                      (value) =>
                                          carCubit.setMaxSpeed(value.kmh),
                                ),
                                _Slider(
                                  name: 'Speed (km/h)',
                                  min: 0,
                                  max: carCubit.state.maxSpeed.toKmh,
                                  value: carCubit.state.speed.toKmh,
                                  onChanged:
                                      (value) => carCubit.setSpeed(value.kmh),
                                ),
                                SizedBox(height: 12),
                                _Slider(
                                  name: 'Max Revs (rpm)',
                                  min: RotFreq.unit.toRpm,
                                  max: RotFreq.unit.toRpm * 12,
                                  divisions: 11,
                                  value: carCubit.state.maxRevs.toRpm,
                                  onChanged:
                                      (value) => carCubit.setMaxRevs(value.rpm),
                                ),
                                _Slider(
                                  name: 'Redline (rpm)',
                                  min: RotFreq.unit.toRpm,
                                  max: carCubit.state.maxRevs.toRpm,
                                  divisions: max(
                                    1,
                                    RotFreq.ratio(
                                          carCubit.state.maxRevs,
                                          RotFreq.unit,
                                        ).floor() -
                                        1,
                                  ),
                                  value: carCubit.state.redline.toRpm,
                                  onChanged:
                                      (value) => carCubit.setRedline(value.rpm),
                                ),
                                _Slider(
                                  name: 'Revs (rpm)',
                                  min: 0.0,
                                  max: carCubit.state.maxRevs.toRpm,
                                  value: carCubit.state.revs.toRpm,
                                  onChanged:
                                      (value) => carCubit.setRevs(value.rpm),
                                ),
                                SizedBox(height: 12),
                                _Slider(
                                  name: 'Mileage (km)',
                                  min: 0,
                                  max: 999999,
                                  value: carCubit.state.mileage.toKm,
                                  onChanged:
                                      (value) => carCubit.setMileage(value.km),
                                ),
                                _Slider(
                                  name: 'Gear',
                                  min: carCubit.state.minGears.toDouble(),
                                  max: carCubit.state.maxGears.toDouble(),
                                  divisions:
                                      carCubit.state.maxGears -
                                      carCubit.state.minGears,
                                  value: carCubit.state.gear.toDouble(),
                                  onChanged:
                                      (gear) => carCubit.shiftTo(gear.round()),
                                ),
                                _Slider(
                                  name: 'Fuel',
                                  min: 0.0,
                                  max: 1.0,
                                  value: carCubit.state.fuel,
                                  onChanged: carCubit.setFuel,
                                ),
                                _Slider(
                                  name: 'Temperature',
                                  min: 0.0,
                                  max: 1.0,
                                  value: carCubit.state.temperature,
                                  onChanged: carCubit.setTemperature,
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _Toggle(
                                      icon: SvgIcons.left,
                                      value: carCubit.state.leftTurnSignal,
                                      onTap: carCubit.toggleLeftTurnSignal,
                                    ),
                                    _Toggle(
                                      icon: SvgIcons.right,
                                      value: carCubit.state.rightTurnSignal,
                                      onTap: carCubit.toggleRightTurnSignal,
                                    ),
                                    _Toggle(
                                      icon: SvgIcons.doors,
                                      value: carCubit.state.doorSignal,
                                      onTap: carCubit.toggleDoorSignal,
                                    ),
                                    _Toggle(
                                      icon: SvgIcons.brakes,
                                      value: carCubit.state.brakesSignal,
                                      onTap: carCubit.toggleBrakesSignal,
                                    ),
                                    _Toggle(
                                      icon: SvgIcons.battery,
                                      value: carCubit.state.batterySignal,
                                      onTap: carCubit.toggleBatterySignal,
                                    ),
                                    _Toggle(
                                      icon: SvgIcons.transmission,
                                      value: carCubit.state.transmissionSignal,
                                      onTap: carCubit.toggleTransmissionSignal,
                                    ),
                                    _Toggle(
                                      icon: SvgIcons.engine,
                                      value: carCubit.state.engineSignal,
                                      onTap: carCubit.toggleEngineSignal,
                                    ),
                                    _Toggle(
                                      icon: SvgIcons.wrench,
                                      value: carCubit.state.serviceSignal,
                                      onTap: carCubit.toggleServiceSignal,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                          : SizedBox(width: double.infinity),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  const _Slider({
    required this.name,
    required this.value,
    required this.min,
    required this.max,
    this.divisions,
    this.onChanged,
  });

  final String name;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 130, child: Text(name)),
          VerticalDivider(indent: 4, endIndent: 4),
          Text('${min.round()}'),
          Expanded(
            child: Slider(
              min: min,
              max: max,
              divisions: divisions,
              value: value,
              onChanged: onChanged,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            ),
          ),
          Text('${max.round()}'),
        ],
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  const _Toggle({required this.icon, required this.value, this.onTap});

  final SvgIconData icon;
  final bool value;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return value
        ? IconButton.filledTonal(
          onPressed: onTap,
          icon: SvgIcon(icon, color: theme.colorScheme.primary),
        )
        : IconButton(
          onPressed: onTap,
          icon: SvgIcon(icon, color: theme.colorScheme.primary),
        );
  }
}
