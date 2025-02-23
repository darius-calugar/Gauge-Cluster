import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/blocs/playground/playground_cubit.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
import 'package:gauge_cluster/examples/e0/gauge_cluster.dart';
import 'package:gauge_cluster/examples/e1/gauge_cluster.dart';
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
                      child: FittedBox(
                        child: SizedBox(
                          width: 800,
                          height: 600,
                          child: AnimatedSwitcher(
                            duration: Durations.short2,
                            transitionBuilder:
                                (child, animation) => FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                            child: switch (playgroundCubit.state) {
                              PlaygroundState(example: 0) => E0GaugeCluster(),
                              PlaygroundState(example: 1) => E1GaugeCluster(),
                              PlaygroundState(example: 2) => E2GaugeCluster(),
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
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _Slider(
                                  name: 'Max Speed (km/h)',
                                  min: 20,
                                  max: 400,
                                  divisions: 19,
                                  value: carCubit.state.maxSpeed,
                                  onChanged: carCubit.setMaxSpeed,
                                ),
                                _Slider(
                                  name: 'Speed (km/h)',
                                  max: carCubit.state.maxSpeed,
                                  value: carCubit.state.speed,
                                  onChanged: carCubit.setSpeed,
                                ),
                                SizedBox(height: 16),
                                _Slider(
                                  name: 'Max Revs (rpm)',
                                  min: 1000,
                                  max: 12000,
                                  divisions: 11,
                                  value: carCubit.state.maxRevs,
                                  onChanged: carCubit.setMaxRevs,
                                ),
                                _Slider(
                                  name: 'Redline (rpm)',
                                  max: carCubit.state.maxRevs,
                                  divisions: carCubit.state.maxRevs ~/ 1000,
                                  value: carCubit.state.redline,
                                  onChanged: carCubit.setRedline,
                                ),
                                _Slider(
                                  name: 'Revs (rpm)',
                                  max: carCubit.state.maxRevs,
                                  value: carCubit.state.revs,
                                  onChanged: carCubit.setRevs,
                                ),
                                SizedBox(height: 16),
                                _Slider(
                                  name: 'Mileage (km)',
                                  max: 999999,
                                  value: carCubit.state.mileage.toDouble(),
                                  onChanged:
                                      (mileage) =>
                                          carCubit.setMileage(mileage.round()),
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
                                  value: carCubit.state.fuel,
                                  onChanged: carCubit.setFuel,
                                ),
                                _Slider(
                                  name: 'Temperature',
                                  value: carCubit.state.temperature,
                                  onChanged: carCubit.setTemperature,
                                ),
                                SizedBox(height: 16),
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
    this.min = 0,
    this.max = 1,
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
