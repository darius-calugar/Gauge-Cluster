import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/blocs/playground/playground_cubit.dart';
import 'package:gauge_cluster/components/svg_icon/svg_icon.dart';
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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Slider(
                    max: carCubit.state.maxSpeed,
                    value: carCubit.state.speed,
                    onChanged: carCubit.setSpeed,
                  ),
                  _Slider(
                    max: carCubit.state.maxRevs,
                    value: carCubit.state.revs,
                    onChanged: carCubit.setRevs,
                  ),
                  _Slider(
                    max: 999999,
                    value: carCubit.state.mileage.toDouble(),
                    onChanged:
                        (mileage) => carCubit.setMileage(mileage.round()),
                  ),
                  _Slider(
                    min: carCubit.state.minGears.toDouble(),
                    max: carCubit.state.maxGears.toDouble(),
                    divisions:
                        carCubit.state.maxGears - carCubit.state.minGears,
                    value: carCubit.state.gear.toDouble(),
                    onChanged: (gear) => carCubit.shiftTo(gear.round()),
                  ),
                  _Slider(
                    value: carCubit.state.fuel,
                    onChanged: carCubit.setFuel,
                  ),
                  _Slider(
                    value: carCubit.state.temperature,
                    onChanged: carCubit.setTemperature,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            ),
          ),
        ],
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  const _Slider({
    required this.value,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.onChanged,
  });

  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${min.round()}'),
        Expanded(
          child: Slider(
            min: min,
            max: max,
            divisions: divisions,
            value: value,
            onChanged: onChanged,
          ),
        ),
        Text('${max.round()}'),
      ],
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
