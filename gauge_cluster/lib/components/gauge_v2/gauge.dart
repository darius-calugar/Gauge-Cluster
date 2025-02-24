import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/gauge_part_shape.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/utils/math/circle/circle_sector.dart';
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
      child: Container(width: 1, height: 1, color: AppColors.red1),
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

    return Positioned.fill(
      child: CustomPaint(painter: _SectorPainter(sector: sector)),
    );
  }
}

class _SectorPainter extends CustomPainter {
  _SectorPainter({required this.sector});

  final CircleSector sector;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final innerRect = Rect.fromCircle(
      center: center,
      radius: sector.innerRadius,
    );
    final outerRect = Rect.fromCircle(
      center: center,
      radius: sector.outerRadius,
    );

    final innerPath = Path()..addOval(innerRect);
    final outerPath =
        sector.sweepAngle == Angle.full ? (Path()..addOval(outerRect)) : Path()
          ..addArc(outerRect, sector.startAngle.toRad, sector.sweepAngle.toRad)
          ..lineTo(center.dx, center.dy);
    final path = Path.combine(PathOperation.difference, outerPath, innerPath);

    final paint = Paint()..color = AppColors.green1;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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

    final size = Size(rect.ring.thickness, rect.width);

    return SizedBox.fromSize(
      size: size,
      child: Container(
        color: AppColors.blue1,
        transform:
            Matrix4.identity()
              ..translate(size.width / 2, size.height / 2, 0)
              ..rotateZ(rect.angle.toRad)
              ..translate(rect.innerRadius, -size.height / 2, 0),
      ),
    );
  }
}
