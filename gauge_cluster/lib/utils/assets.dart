import 'dart:ui' as ui;

import 'package:flutter/services.dart';

extension type const SvgIconData(String path) {}

abstract final class SvgIcons {
  static const battery = SvgIconData('assets/svgs/icons/battery.svg');
  static const brakes = SvgIconData('assets/svgs/icons/brakes.svg');
  static const doors = SvgIconData('assets/svgs/icons/doors.svg');
  static const engine = SvgIconData('assets/svgs/icons/engine.svg');
  static const fuel = SvgIconData('assets/svgs/icons/fuel.svg');
  static const left = SvgIconData('assets/svgs/icons/left.svg');
  static const right = SvgIconData('assets/svgs/icons/right.svg');
  static const temperature = SvgIconData('assets/svgs/icons/temperature.svg');
  static const transmission = SvgIconData('assets/svgs/icons/transmission.svg');
  static const wrench = SvgIconData('assets/svgs/icons/wrench.svg');
}

abstract final class Textures {
  static Future<void> load() async {
    final buffer = await rootBundle.loadBuffer(
      'assets/textures/bump/plastic_1.png',
    );
    final codec = await ui.instantiateImageCodecFromBuffer(buffer);
    final frame = await codec.getNextFrame();
    bumpPlastic1 = frame.image;
  }

  static late final ui.Image bumpPlastic1;
}
