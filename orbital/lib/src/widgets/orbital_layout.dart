import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:orbital/src/models/math/orbital_constraints.dart';
import 'package:orbital/src/models/orbital_parent_data.dart';
import 'package:orbital/src/render/render_orbital.dart';

class OrbitalLayout extends SingleChildRenderObjectWidget {
  const OrbitalLayout({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderOrbitalLayout();
}

class RenderOrbitalLayout extends RenderBox
    with RenderObjectWithChildMixin<RenderOrbital> {
  RenderOrbitalLayout();

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! OrbitalParentData) {
      child.parentData = OrbitalParentData(parentData: null);
    }
  }

  @override
  void performLayout() {
    final radius = constraints.biggest.shortestSide / 2;

    final childConstraints = OrbitalConstraints(
      minThickness: 0,
      maxThickness: radius,
      minSweepAngle: 0,
      maxSweepAngle: 2 * pi,
    );

    var newSize = constraints.smallest;
    if (child case final child?) {
      child.layout(childConstraints, parentUsesSize: true);
      final childSize = child.bounds.size;
      newSize = Size(
        max(newSize.width, childSize.width),
        max(newSize.height, childSize.height),
      );
    }

    size = newSize;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child case final child?) {
      final radius = size.shortestSide / 2;
      final outerRadiusDelta = radius - child.outerRadius;
      final localOffset = Offset(outerRadiusDelta, outerRadiusDelta);
      context.paintChild(child, offset + localOffset);
    }
  }
}
