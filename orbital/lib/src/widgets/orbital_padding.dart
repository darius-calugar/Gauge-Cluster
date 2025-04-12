import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:orbital/orbital.dart';

/// Orbital equivalent for the [Padding] widget.
class OrbitalPadding extends SingleChildRenderObjectWidget {
  const OrbitalPadding({
    super.key,
    super.child,
    this.padding = OrbitalEdgeInsets.zero,
  });

  final OrbitalEdgeInsets padding;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderOrbitalPadding(padding: padding);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderOrbitalPadding renderObject,
  ) => renderObject.update(padding: padding);
}

class RenderOrbitalPadding extends RenderOrbital
    with RenderObjectWithChildMixin<RenderOrbital> {
  RenderOrbitalPadding({required this.padding});

  OrbitalEdgeInsets padding;

  void update({OrbitalEdgeInsets? padding}) {
    this.padding = padding ?? this.padding;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    if (child case final child?) {
      final childConstraints = constraints.deflate(padding);
      child.layout(childConstraints, parentUsesSize: true);
      size = child.size.inflate(padding);

      final childParentData = child.parentData as OrbitalParentData;
      childParentData.localOffset = OrbitalOffset(
        dr: padding.inner,
        da: padding.start,
      );
    } else {
      size = constraints.smallest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child case final child?) {
      final outerRadiusDelta = outerRadius - child.outerRadius;
      final localOffset = Offset(outerRadiusDelta, outerRadiusDelta);
      context.paintChild(child, offset + localOffset);
    }
  }
}
