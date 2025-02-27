import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_fill.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_shape.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_shadow.dart';
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
    final shape = part.shape as GaugeRectShape;
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
                left:
                    circle.radius +
                    part.centerOffset.offset.dx +
                    rect.center.offset.dx,
                top:
                    circle.radius +
                    part.centerOffset.offset.dy +
                    rect.center.offset.dy,
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
    final circleCenterOffset =
        Offset(circle.radius, circle.radius) + part.centerOffset.offset;

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

    // Shadows
    for (final shadow in part.shadows ?? <GaugeShadow>[]) {
      final shadowPath = path.shift(shadow.offset);
      final shadowPaint = shadow.toPaint();
      canvas.drawPath(shadowPath, shadowPaint);
    }

    // Fill
    final fillPaint = switch (part.fill) {
      null => null,
      GaugeSolidFill fill => Paint()..color = fill.color,
      GaugeLinearGradientFill fill =>
        Paint()
          ..shader = fill
              .getGradient(
                circle,
                CircleLine(start: rect.innerMid, end: rect.outerMid),
              )
              .createShader(canvasRect),
      GaugeSweepGradientFill fill =>
        Paint()
          ..shader = fill.getGradient(rect.innerSlice).createShader(canvasRect),
      GaugeRadialGradientFill fill =>
        Paint()
          ..shader = fill
              .getGradient(circle, rect.ring)
              .createShader(canvasRect),
    };
    if (fillPaint != null) canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _RectPainter oldDelegate) =>
      part != oldDelegate.part;
}
