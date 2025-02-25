import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge.dart';

class GaugePartPointShapeWidget extends StatelessWidget {
  const GaugePartPointShapeWidget({
    super.key,
    required this.part,
    required this.circleRadius,
  });

  final GaugePart part;
  final double circleRadius;

  @override
  Widget build(BuildContext context) {
    final shape = part.shape as GaugePartPointShape;
    final point = shape.point;

    return Positioned(
      left: circleRadius + point.radius * point.angle.cos,
      top: circleRadius - point.radius * point.angle.sin,
      child: SizedOverflowBox(size: Size.zero, child: part.child),
    );
  }
}
