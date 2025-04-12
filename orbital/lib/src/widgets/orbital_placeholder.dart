import 'package:flutter/widgets.dart';
import 'package:orbital/src/models/math/orbital_size.dart';
import 'package:orbital/src/render/render_orbital.dart';

/// Orbital equivalent for the [Placeholder] widget.
class OrbitalPlaceholder extends LeafRenderObjectWidget {
  const OrbitalPlaceholder({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderOrbitalPlaceholder();
}

class RenderOrbitalPlaceholder extends RenderOrbital {
  @override
  bool get sizedByParent => true;

  @override
  OrbitalSize computeDryLayout() => constraints.biggest;

  @override
  void paint(PaintingContext context, Offset offset) {
    final path = sector.toPath().shift(offset);

    final fillPaint =
        Paint()
          ..color = const Color(0x22FF00FF)
          ..style = PaintingStyle.fill;
    final strokePaint =
        Paint()
          ..color = const Color(0xFFFF00FF)
          ..style = PaintingStyle.stroke;

    context.canvas.drawPath(path, fillPaint);
    context.canvas.drawPath(path, strokePaint);
  }
}
