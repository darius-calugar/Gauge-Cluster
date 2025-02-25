import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_fill.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_shape.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_line.dart';
import 'package:gauge_cluster/utils/math/circle/circle_point.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class GaugePartSectorShapeWidget extends StatelessWidget {
  const GaugePartSectorShapeWidget({
    super.key,
    required this.part,
    required this.circleRadius,
  });

  final GaugePart part;
  final double circleRadius;

  @override
  Widget build(BuildContext context) {
    final shape = part.shape as GaugePartSectorShape;
    final sector = shape.sector;

    final clipper = _SectorClipper(part: part);
    final painter = _SectorPainter(part: part, clipper: clipper);

    return Positioned.fill(
      child: CustomPaint(
        painter: painter,
        child: ClipPath(
          clipper: clipper,
          child: Stack(
            children: [
              Positioned(
                left: circleRadius + sector.center.offset.dx,
                top: circleRadius + sector.center.offset.dy,
                child: SizedOverflowBox(size: Size.zero, child: part.child),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectorClipper extends CustomClipper<Path> {
  _SectorClipper({required this.part});

  final GaugePart part;

  @override
  Path getClip(Size size) {
    final shape = part.shape as GaugePartSectorShape;
    final sector = shape.sector;

    final circleCenter = size.center(Offset.zero);
    final innerRect = Rect.fromCircle(
      center: circleCenter,
      radius: sector.innerRadius,
    );
    final outerRect = Rect.fromCircle(
      center: circleCenter,
      radius: sector.outerRadius,
    );

    final innerPath = Path()..addOval(innerRect);
    final outerPath =
        sector.sweepAngle == Angle.full ? (Path()..addOval(outerRect)) : Path()
          ..addArc(outerRect, sector.startAngle.toRad, sector.sweepAngle.toRad)
          ..lineTo(circleCenter.dx, circleCenter.dy);
    final path = Path.combine(PathOperation.difference, outerPath, innerPath);

    return path;
  }

  @override
  bool shouldReclip(covariant _SectorClipper oldClipper) =>
      part != oldClipper.part;
}

class _SectorPainter extends CustomPainter {
  _SectorPainter({required this.part, required this.clipper});

  final GaugePart part;
  final _SectorClipper clipper;

  @override
  void paint(Canvas canvas, Size size) {
    final shape = part.shape as GaugePartSectorShape;
    final sector = shape.sector;

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
                CircleLine(
                  start: sector.innerLine.middle,
                  end: CirclePoint(
                    radius: sector.outerRadius,
                    angle: sector.midAngle,
                  ),
                ),
              )
              .createShader(Offset.zero & size),
      GaugePartSweepGradientFill fill =>
        Paint()
          ..shader = fill
              .getGradient(sector.slice)
              .createShader(Offset.zero & size),
      GaugePartRadialGradientFill fill =>
        Paint()
          ..shader = fill
              .getGradient(circle, sector.ring)
              .createShader(Offset.zero & size),
    };

    if (paint != null) {
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SectorPainter oldDelegate) =>
      part != oldDelegate.part;
}
