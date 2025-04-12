import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:orbital/orbital.dart';

class OrbitalConstrained extends SingleChildRenderObjectWidget {
  const OrbitalConstrained({super.key, super.child, required this.constraints});

  final OrbitalConstraints constraints;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderOrbitalConstrained(additionalConstraints: constraints);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderOrbitalConstrained renderObject,
  ) => renderObject.additionalConstraints = constraints;
}

class RenderOrbitalConstrained extends RenderOrbital
    with RenderObjectWithChildMixin<RenderOrbital> {
  RenderOrbitalConstrained({required this.additionalConstraints});

  OrbitalConstraints additionalConstraints;

  @override
  void performLayout() {
    final childConstraints = additionalConstraints.enforce(constraints);
    if (child case final child?) {
      child.layout(childConstraints, parentUsesSize: true);
      size = child.size;
    } else {
      size = childConstraints.smallest;
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
