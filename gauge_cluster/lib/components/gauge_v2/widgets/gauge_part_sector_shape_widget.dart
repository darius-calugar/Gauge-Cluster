import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_fill.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_shape.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_shadow.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_line.dart';
import 'package:gauge_cluster/utils/math/circle/circle_point.dart';
import 'package:gauge_cluster/utils/math/circle/circle_sector.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class GaugePartSectorShapeWidget extends StatelessWidget {
  const GaugePartSectorShapeWidget({
    super.key,
    required this.circle,
    required this.part,
  });

  final Circle circle;
  final GaugePart part;

  @override
  Widget build(BuildContext context) {
    final shape = part.shape as GaugeSectorShape;
    final sector = shape.getSector(circle);

    final clipper = _SectorClipper(circle: circle, part: part, sector: sector);
    final painter = _SectorPainter(
      circle: circle,
      part: part,
      sector: sector,
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
                    sector.center.offset.dx,
                top:
                    circle.radius +
                    part.centerOffset.offset.dy +
                    sector.center.offset.dy,
                child: SizedOverflowBox(
                  size: Size.zero,
                  child: Transform.rotate(
                    angle:
                        part.isRotated
                            ? (Angle.quarter + sector.center.angle).toRad
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

class _SectorClipper extends CustomClipper<Path> {
  _SectorClipper({
    required this.circle,
    required this.part,
    required this.sector,
  });

  final Circle circle;
  final GaugePart part;
  final CircleSector sector;

  @override
  Path getClip(Size size) {
    final circleCenterOffset =
        Offset(circle.radius, circle.radius) + part.centerOffset.offset;
    final innerRect = Rect.fromCircle(
      center: circleCenterOffset,
      radius: sector.innerRadius,
    );
    final outerRect = Rect.fromCircle(
      center: circleCenterOffset,
      radius: sector.outerRadius,
    );

    final innerPath = Path()..addOval(innerRect);
    final outerPath =
        sector.sweepAngle == Angle.full ? (Path()..addOval(outerRect)) : Path()
          ..addArc(outerRect, sector.startAngle.toRad, sector.sweepAngle.toRad)
          ..lineTo(circleCenterOffset.dx, circleCenterOffset.dy);
    final path = Path.combine(PathOperation.difference, outerPath, innerPath);

    return path;
  }

  @override
  bool shouldReclip(covariant _SectorClipper oldClipper) =>
      part != oldClipper.part;
}

class _SectorPainter extends CustomPainter {
  _SectorPainter({
    required this.circle,
    required this.part,
    required this.sector,
    required this.clipper,
  });

  final Circle circle;
  final GaugePart part;
  final CircleSector sector;
  final _SectorClipper clipper;

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
                CircleLine(
                  start: sector.innerLine.middle,
                  end: CirclePoint(
                    radius: sector.outerRadius,
                    angle: sector.midAngle,
                  ),
                ),
              )
              .createShader(canvasRect),
      GaugeSweepGradientFill fill =>
        Paint()
          ..shader = fill.getGradient(sector.slice).createShader(canvasRect),
      GaugeRadialGradientFill fill =>
        Paint()
          ..shader = fill
              .getGradient(circle, sector.ring)
              .createShader(canvasRect),
    };
    if (fillPaint != null) canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _SectorPainter oldDelegate) =>
      part != oldDelegate.part;
}
