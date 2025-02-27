import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_fill.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_shape.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_line.dart';
import 'package:gauge_cluster/utils/math/circle/circle_rect.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class GaugePartRectShapeWidget extends StatelessWidget {
  const GaugePartRectShapeWidget({
    super.key,
    required this.circle,
    required this.part,
  });

  final Circle circle;
  final GaugePart part;

  @override
  Widget build(BuildContext context) {
    final shape = part.shape as GaugePartRectShape;
    final rect = shape.getRect(circle);

    final clipper = _RectClipper(circle: circle, part: part, rect: rect);
    final painter = _RectPainter(
      circle: circle,
      part: part,
      rect: rect,
      clipper: clipper,
    );

    return Positioned.fill(
      child: CustomPaint(
        painter: painter,
        child: ClipPath(
          clipper: clipper,
          child: Stack(
            children: [
              Positioned(
                left: circle.radius + rect.center.offset.dx,
                top: circle.radius + rect.center.offset.dy,
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
  _RectClipper({required this.circle, required this.part, required this.rect});

  final Circle circle;
  final GaugePart part;
  final CircleRect rect;

  @override
  Path getClip(Size size) {
    final circleCenterOffset = Offset(circle.radius, circle.radius);

    return Path()..addPolygon([
      circleCenterOffset + rect.innerStart.offset,
      circleCenterOffset + rect.innerEnd.offset,
      circleCenterOffset + rect.outerEnd.offset,
      circleCenterOffset + rect.outerStart.offset,
    ], true);
  }

  @override
  bool shouldReclip(covariant _RectClipper oldClipper) =>
      part != oldClipper.part;
}

class _RectPainter extends CustomPainter {
  _RectPainter({
    required this.circle,
    required this.part,
    required this.rect,
    required this.clipper,
  });

  final Circle circle;
  final GaugePart part;
  final CircleRect rect;
  final _RectClipper clipper;

  @override
  void paint(Canvas canvas, Size size) {
    final path = clipper.getClip(size);
    final canvasRect = Offset.zero & Size.square(circle.diameter);

    final shadowPaint = switch (part.shadow) {
      null => null,
      Shadow shadow => shadow.toPaint(),
    };

    final fillPaint = switch (part.fill) {
      null => null,
      GaugePartSolidFill fill => Paint()..color = fill.color,
      GaugePartLinearGradientFill fill =>
        Paint()
          ..shader = fill
              .getGradient(
                circle,
                CircleLine(start: rect.innerMid, end: rect.outerMid),
              )
              .createShader(canvasRect),
      GaugePartSweepGradientFill fill =>
        Paint()
          ..shader = fill.getGradient(rect.innerSlice).createShader(canvasRect),
      GaugePartRadialGradientFill fill =>
        Paint()
          ..shader = fill
              .getGradient(circle, rect.ring)
              .createShader(canvasRect),
    };

    if (shadowPaint != null) canvas.drawPath(path, shadowPaint);
    if (fillPaint != null) canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _RectPainter oldDelegate) =>
      part != oldDelegate.part;
}
