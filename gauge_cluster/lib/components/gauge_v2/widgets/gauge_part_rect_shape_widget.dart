import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_fill.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_shape.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_line.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class GaugePartRectShapeWidget extends StatelessWidget {
  const GaugePartRectShapeWidget({
    super.key,
    required this.part,
    required this.circleRadius,
  });

  final GaugePart part;
  final double circleRadius;

  @override
  Widget build(BuildContext context) {
    final shape = part.shape as GaugePartRectShape;
    final rect = shape.rect;

    final clipper = _RectClipper(part: part);
    final painter = _RectPainter(part: part, clipper: clipper);

    return Positioned.fill(
      child: CustomPaint(
        painter: painter,
        child: ClipPath(
          clipper: clipper,
          child: Stack(
            children: [
              Positioned(
                left: circleRadius + rect.center.offset.dx,
                top: circleRadius + rect.center.offset.dy,
                child: SizedOverflowBox(
                  size: Size.zero,
                  child: Transform.rotate(
                    angle:
                        part.isRotated
                            ? (Angle.quarter + rect.center.angle).toRad
                            : 0,
                    child: part.child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RectClipper extends CustomClipper<Path> {
  _RectClipper({required this.part});

  final GaugePart part;

  @override
  Path getClip(Size size) {
    final shape = part.shape as GaugePartRectShape;
    final rect = shape.rect;

    final circleCenter = size.center(Offset.zero);
    return Path()..addPolygon([
      circleCenter + rect.innerStart.offset,
      circleCenter + rect.innerEnd.offset,
      circleCenter + rect.outerEnd.offset,
      circleCenter + rect.outerStart.offset,
    ], true);
  }

  @override
  bool shouldReclip(covariant _RectClipper oldClipper) =>
      part != oldClipper.part;
}

class _RectPainter extends CustomPainter {
  _RectPainter({required this.part, required this.clipper});

  final GaugePart part;
  final _RectClipper clipper;

  @override
  void paint(Canvas canvas, Size size) {
    final shape = part.shape as GaugePartRectShape;
    final rect = shape.rect;

    final circle = Circle.fromSize(size);

    final path = clipper.getClip(size);

    final paint = switch (part.fill) {
      null => null,
      GaugePartSolidFill fill => Paint()..color = fill.color,
      GaugePartLinearGradientFill fill =>
        Paint()
          ..shader = fill
              .getGradient(
                circle,
                CircleLine(start: rect.innerMid, end: rect.outerMid),
              )
              .createShader(Offset.zero & size),
      GaugePartSweepGradientFill fill =>
        Paint()
          ..shader = fill
              .getGradient(rect.innerSlice)
              .createShader(Offset.zero & size),
      GaugePartRadialGradientFill fill =>
        Paint()
          ..shader = fill
              .getGradient(circle, rect.ring)
              .createShader(Offset.zero & size),
    };

    if (paint != null) {
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RectPainter oldDelegate) =>
      part != oldDelegate.part;
}
