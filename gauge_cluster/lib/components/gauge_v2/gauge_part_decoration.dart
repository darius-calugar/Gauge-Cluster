import 'dart:ui';

import 'package:equatable/equatable.dart';

/// Base class for gauge decorations.
///
/// Gauge decorations define the appearance of the gauge parts.
class GaugePartDecoration extends Equatable {
  const GaugePartDecoration({this.color});

  final Color? color;

  @override
  List<Object?> get props => [color];
}
