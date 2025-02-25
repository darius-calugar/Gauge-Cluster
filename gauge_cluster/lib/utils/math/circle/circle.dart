import 'package:equatable/equatable.dart';
import 'package:gauge_cluster/utils/math/circle/circle_point.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class Circle extends Equatable {
  const Circle({required this.radius});

  static const Circle zero = Circle(radius: 0);

  final double radius;

  double get diameter => radius * 2;

  CirclePoint get center => CirclePoint(radius: 0, angle: Angle.zero);
  CirclePoint get right => CirclePoint(radius: radius, angle: Angle.right);
  CirclePoint get bottom => CirclePoint(radius: radius, angle: Angle.bottom);
  CirclePoint get left => CirclePoint(radius: radius, angle: Angle.left);
  CirclePoint get top => CirclePoint(radius: radius, angle: Angle.top);

  @override
  List<Object?> get props => [radius];
}
