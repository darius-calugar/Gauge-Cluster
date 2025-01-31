import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/examples/e1/gauge_cluster.dart';
import 'package:gauge_cluster/examples/e1/rev_gauge.dart';
import 'package:gauge_cluster/examples/e1/speed_gauge.dart';

class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({super.key});

  @override
  State<PlaygroundScreen> createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
  double currentSpeed = 86;
  double currentRevs = 3500;
  int currentGear = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: E1GaugeCluster(
              currentSpeed: currentSpeed,
              currentRevs: currentRevs,
              currentGear: currentGear,
            ),
          ),
        ),
        Container(
          height: 200,
          padding: EdgeInsets.all(16),
          color: AppColors.black1,
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: [
                CupertinoSlider(
                  value: currentSpeed,
                  min: 0,
                  max: E1SpeedGauge.outerTopSpeed,
                  onChanged: (newSpeed) => setState(() {
                    currentSpeed = newSpeed;
                  }),
                ),
                CupertinoSlider(
                  value: currentRevs,
                  min: 0,
                  max: E1RevGauge.maxRevs,
                  onChanged: (newRevs) => setState(() {
                    currentRevs = newRevs;
                  }),
                ),
                CupertinoSlider(
                  value: currentGear.toDouble(),
                  divisions: E1RevGauge.maxGears - E1RevGauge.minGears,
                  min: E1RevGauge.minGears.toDouble(),
                  max: E1RevGauge.maxGears.toDouble(),
                  onChanged: (newGear) => setState(() {
                    currentGear = newGear.round();
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
