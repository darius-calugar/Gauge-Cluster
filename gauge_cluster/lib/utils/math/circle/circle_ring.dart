import 'package:equatable/equatable.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';

class CircleRing extends Equatable {
  CircleRing({
    required Circle circle,
    double? innerRadius,
    double? outerRadius,
    double? thickness,
  }) : assert(innerRadius == null || outerRadius == null || thickness == null) {
    if (outerRadius == null) {
      this.innerRadius = innerRadius ?? 0;
      this.thickness = thickness ?? (circle.radius - this.innerRadius);
      this.outerRadius = this.innerRadius + this.thickness;
    } else if (innerRadius == null) {
      this.outerRadius = outerRadius;
      this.thickness = thickness ?? this.outerRadius;
      this.innerRadius = this.outerRadius - this.thickness;
    } else if (thickness == null) {
      this.innerRadius = innerRadius;
      this.outerRadius = outerRadius;
      this.thickness = this.outerRadius - this.innerRadius;
    }
  }

  factory CircleRing.inset({
    required Circle circle,
    double? innerInset,
    double? outerInset,
    double? thickness,
  }) => CircleRing(
    circle: circle,
    innerRadius: innerInset,
    outerRadius: outerInset != null ? circle.radius - outerInset : null,
    thickness: thickness,
  );

  late final double innerRadius;
  late final double outerRadius;
  late final double thickness;

  @override
  List<Object?> get props => [innerRadius, outerRadius, thickness];
}
