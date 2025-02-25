import 'dart:ui';

import 'package:equatable/equatable.dart';

/// Base class for gauge decorations.
///
/// Gauge decorations define the appearance of the gauge parts.
sealed class GaugePartDecoration extends Equatable {
  const GaugePartDecoration();
}

final class GaugePartSolidDecoration extends GaugePartDecoration {
  const GaugePartSolidDecoration({this.color});

  final Color? color;

  @override
  List<Object?> get props => [color];
}
