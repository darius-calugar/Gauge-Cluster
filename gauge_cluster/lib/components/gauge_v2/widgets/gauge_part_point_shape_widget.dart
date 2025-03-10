import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class GaugePartPointShapeWidget extends StatelessWidget {
  const GaugePartPointShapeWidget({
    super.key,
    required this.circle,
    required this.part,
  });

  final Circle circle;
  final GaugePart part;

  @override
  Widget build(BuildContext context) {
    final shape = part.shape as GaugePointShape;
    final point = shape.getPoint(circle);

    assert(part.fill == null, 'Point parts do not support fills.');
    assert(part.shadows == null, 'Point parts do not support shadows.');

    return Positioned(
      left: circle.radius + part.centerOffset.offset.dx + point.offset.dx,
      top: circle.radius + part.centerOffset.offset.dy + point.offset.dy,
      child: SizedOverflowBox(
        size: Size.zero,
        child: Transform.rotate(
          angle: part.isRotated ? (Angle.quarter + point.angle).toRad : 0,
          child: part.child,
        ),
      ),
    );
  }
}
