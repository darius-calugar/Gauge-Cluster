import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge_part_shape.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class Gauge extends StatelessWidget {
  const Gauge({super.key, required this.parts});

  final List<GaugePart> parts;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final circleDiameter = constraints.biggest.shortestSide;
        final circleRadius = circleDiameter / 2;

        return SizedBox.square(
          dimension: circleDiameter,
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              for (final part in parts)
                switch (part.shape) {
                  GaugePartPointShape() => _PointShapeWidget(
                    part: part,
                    circleRadius: circleRadius,
                  ),
                  GaugePartSectorShape() => _SectorShapeWidget(
                    part: part,
                    circleRadius: circleRadius,
                  ),
                  GaugePartRectShape() => _RectShapeWidget(
                    part: part,
                    circleRadius: circleRadius,
                  ),
                },
            ],
          ),
        );
      },
    );
  }
}

/// Widget that renders a point shape.
class _PointShapeWidget extends StatelessWidget {
  const _PointShapeWidget({required this.part, required this.circleRadius});

  final GaugePart part;
  final double circleRadius;

  @override
  Widget build(BuildContext context) {
    final shape = part.shape as GaugePartPointShape;
    final point = shape.point;

    return Positioned(
      left: circleRadius + point.radius * point.angle.cos,
      top: circleRadius - point.radius * point.angle.sin,
      child: SizedOverflowBox(
        size: Size.zero,
        child: Container(
          decoration: BoxDecoration(color: part.decoration?.color),
          child: part.child,
        ),
      ),
    );
  }
}

/// Widget that renders a sector shape.
class _SectorShapeWidget extends StatelessWidget {
  const _SectorShapeWidget({required this.part, required this.circleRadius});

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
    final path = clipper.getClip(size);

    final paint = Paint()..color = part.decoration?.color ?? Color(0x00000000);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SectorPainter oldDelegate) =>
      part != oldDelegate.part;
}

/// Widget that renders a rect shape.
class _RectShapeWidget extends StatelessWidget {
  const _RectShapeWidget({required this.part, required this.circleRadius});

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
                child: SizedOverflowBox(size: Size.zero, child: part.child),
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
    final path = clipper.getClip(size);

    final paint = Paint()..color = part.decoration?.color ?? Color(0x00000000);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RectPainter oldDelegate) =>
      part != oldDelegate.part;
}
