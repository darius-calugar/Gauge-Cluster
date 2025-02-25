import 'package:equatable/equatable.dart';
import 'package:gauge_cluster/utils/math/circle/circle_point.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';
import 'dart:math';

class CircleLine extends Equatable {
  const CircleLine({required this.start, required this.end});

  final CirclePoint start;
  final CirclePoint end;

  CirclePoint get middle =>
      CirclePoint.fromOffset((start.offset + end.offset) / 2);

  double get slope =>
      (end.offset.dy - start.offset.dy) / (end.offset.dx - start.offset.dx);
  Angle get direction => atan(slope).rad;

  @override
  List<Object?> get props => [start, end];
}
