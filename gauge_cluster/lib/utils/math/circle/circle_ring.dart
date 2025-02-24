import 'package:equatable/equatable.dart';

class CircleRing extends Equatable {
  CircleRing({
    required double circleRadius,
    double? innerRadius,
    double? outerRadius,
    double? thickness,
  }) : assert(innerRadius == null || outerRadius == null || thickness == null) {
    if (outerRadius == null) {
      this.innerRadius = innerRadius ?? 0;
      this.thickness = thickness ?? (circleRadius - this.innerRadius);
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
    required double circleRadius,
    double? innerInset,
    double? outerInset,
    double? thickness,
  }) => CircleRing(
    circleRadius: circleRadius,
    innerRadius: innerInset,
    outerRadius: outerInset != null ? circleRadius - outerInset : null,
    thickness: thickness,
  );

  late final double innerRadius;
  late final double outerRadius;
  late final double thickness;

  @override
  List<Object?> get props => [innerRadius, outerRadius, thickness];
}
