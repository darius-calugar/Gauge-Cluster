import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:orbital/orbital.dart';

/// Orbital equivalent for the [Flex] widget.
class OrbitalFlex extends MultiChildRenderObjectWidget {
  const OrbitalFlex({
    super.key,
    super.children,
    required this.axis,
    this.radialDirection = OrbitalRadialDirection.outwards,
    this.angularDirection = OrbitalAngularDirection.clockwise,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = 0,
  });

  final OrbitalAxis axis;
  final OrbitalRadialDirection radialDirection;
  final OrbitalAngularDirection angularDirection;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  @override
  RenderObject createRenderObject(BuildContext context) => RenderOrbitalFlex(
    axis: axis,
    radialDirection: radialDirection,
    angularDirection: angularDirection,
    mainAxisSize: mainAxisSize,
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: crossAxisAlignment,
    spacing: spacing,
  );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderOrbitalFlex renderObject,
  ) => renderObject.update(
    axis: axis,
    radialDirection: radialDirection,
    angularDirection: angularDirection,
    mainAxisSize: mainAxisSize,
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: crossAxisAlignment,
    spacing: spacing,
  );
}

/// Orbital equivalent of [RenderFlex].
class RenderOrbitalFlex extends RenderOrbital
    with
        ContainerRenderObjectMixin<RenderOrbital, OrbitalFlexParentData>,
        DebugOrbitalOverflowIndicatorMixin {
  RenderOrbitalFlex({
    required this.axis,
    required this.radialDirection,
    required this.angularDirection,
    required this.mainAxisSize,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.spacing,
  });

  OrbitalAxis axis;
  OrbitalRadialDirection radialDirection;
  OrbitalAngularDirection angularDirection;
  MainAxisSize mainAxisSize;
  MainAxisAlignment mainAxisAlignment;
  CrossAxisAlignment crossAxisAlignment;
  double spacing;

  void update({
    OrbitalAxis? axis,
    OrbitalRadialDirection? radialDirection,
    OrbitalAngularDirection? angularDirection,
    MainAxisSize? mainAxisSize,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    double? spacing,
  }) {
    this.axis = axis ?? this.axis;
    this.radialDirection = radialDirection ?? this.radialDirection;
    this.angularDirection = angularDirection ?? this.angularDirection;
    this.mainAxisSize = mainAxisSize ?? this.mainAxisSize;
    this.mainAxisAlignment = mainAxisAlignment ?? this.mainAxisAlignment;
    this.crossAxisAlignment = crossAxisAlignment ?? this.crossAxisAlignment;
    this.spacing = spacing ?? this.spacing;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! OrbitalFlexParentData) {
      child.parentData = OrbitalFlexParentData(
        parentData: parentData as OrbitalParentData,
      );
    }
  }

  @override
  void performLayout() {
    final sizes = _computeSizes();

    _overflow = math.max(0.0, -sizes.mainAxisFreeSpace);
    final crossAxisExtent = sizes.axisSize.crossAxisExtent;
    final remainingSpace = math.max(0.0, sizes.mainAxisFreeSpace);
    final (leadingSpace, betweenSpace) = _distributeSpace(
      mainAxisAlignment: mainAxisAlignment,
      freeSpace: remainingSpace,
      itemCount: childCount,
      flipped: _flipMainAxis,
      spacing: spacing,
    );
    final (nextChild, initialChild) =
        _flipMainAxis ? (childBefore, lastChild) : (childAfter, firstChild);

    // Position all children in visual order: starting from the top-left child and
    // work towards the child that's farthest away from the origin.
    double childMainPosition = leadingSpace;
    for (var child = initialChild; child != null; child = nextChild(child)) {
      final double childCrossPosition = _getChildCrossAxisOffset(
        crossAxisAlignment: crossAxisAlignment,
        freeSpace: crossAxisExtent - _getCrossSize(child.size),
        flipped: _flipCrossAxis,
      );
      final childParentData = child.parentData! as OrbitalFlexParentData;
      childParentData.localOffset = switch (axis) {
        OrbitalAxis.angular => OrbitalOffset(
          da: childMainPosition,
          dr: childCrossPosition,
        ),
        OrbitalAxis.radial => OrbitalOffset(
          da: childCrossPosition,
          dr: childMainPosition,
        ),
      };
      childMainPosition += _getMainSize(child.size) + betweenSpace;
    }

    size = sizes.axisSize.toOrbitalSize(axis);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(PaintingContext context, Offset offset) {
      final (nextChild, initialChild) =
          _flipMainAxis ? (childBefore, lastChild) : (childAfter, firstChild);
      for (var child = initialChild; child != null; child = nextChild(child)) {
        final outerRadiusDelta = outerRadius - child.outerRadius;
        final localOffset = Offset(outerRadiusDelta, outerRadiusDelta);
        context.paintChild(child, offset + localOffset);
      }
    }

    if (!_hasOverflow) {
      doPaint(context, offset);
      return;
    }

    context.pushClipPath(
      needsCompositing,
      offset,
      bounds,
      sector.toPath(),
      doPaint,
    );

    final overflowSize = _AxisSize(
      mainAxisExtent: _overflow,
      crossAxisExtent: 0,
    ).toOrbitalSize(axis);
    paintOverflowIndicator(context, offset, sector, sector + overflowSize);
  }

  double _overflow = 0.0;

  bool get _hasOverflow => _overflow > precisionErrorTolerance;

  bool get _flipMainAxis =>
      firstChild != null &&
      switch (axis) {
        OrbitalAxis.angular => angularDirection.isFlipped,
        OrbitalAxis.radial => radialDirection.isFlipped,
      };

  bool get _flipCrossAxis =>
      firstChild != null &&
      switch (axis) {
        OrbitalAxis.angular => radialDirection.isFlipped,
        OrbitalAxis.radial => angularDirection.isFlipped,
      };

  _LayoutSizes _computeSizes() {
    // Determine used flex factor, size inflexible items, calculate free space.
    final double maxMainSize = _getMainSize(constraints.biggest);
    final bool canFlex = maxMainSize.isFinite;
    final OrbitalConstraints nonFlexChildConstraints =
        _constraintsForNonFlexChild(constraints);

    // The first pass lays out non-flex children and computes total flex.
    var totalFlex = 0;
    RenderOrbital? firstFlexChild;

    // Initially, accumulatedSize is the sum of the spaces between children in the main axis.
    _AxisSize accumulatedSize = _AxisSize(
      mainAxisExtent: spacing * (childCount - 1),
      crossAxisExtent: 0.0,
    );
    for (var child = firstChild; child != null; child = childAfter(child)) {
      final int flex;
      if (canFlex && (flex = _getFlex(child)) > 0) {
        totalFlex += flex;
        firstFlexChild ??= child;
      } else {
        child.layout(nonFlexChildConstraints);
        final _AxisSize childSize = _AxisSize.fromOrbitalSize(
          size: child.size,
          axis: axis,
        );
        accumulatedSize += childSize;
      }
    }

    // If we are given infinite space there's no need for this extra step.
    assert(firstFlexChild == null || canFlex);
    assert((totalFlex == 0) == (firstFlexChild == null));

    // The second pass distributes free space to flexible children.
    final flexSpace = math.max(
      0.0,
      maxMainSize - accumulatedSize.mainAxisExtent,
    );
    final spacePerFlex = flexSpace / totalFlex;
    for (
      RenderOrbital? child = firstFlexChild;
      child != null && totalFlex > 0;
      child = childAfter(child)
    ) {
      final flex = _getFlex(child);
      if (flex == 0) {
        continue;
      }
      totalFlex -= flex;
      assert(spacePerFlex.isFinite);
      final maxChildExtent = spacePerFlex * flex;
      assert(
        _getFit(child) == FlexFit.loose || maxChildExtent < double.infinity,
      );
      final flexChildConstraints = _constraintsForFlexChild(
        child,
        constraints,
        maxChildExtent,
      );
      child.layout(flexChildConstraints);
      final _AxisSize childSize = _AxisSize.fromOrbitalSize(
        size: child.size,
        axis: axis,
      );
      accumulatedSize += childSize;
    }
    assert(totalFlex == 0);

    final idealMainSize = switch (mainAxisSize) {
      MainAxisSize.max when maxMainSize.isFinite => maxMainSize,
      MainAxisSize.max || MainAxisSize.min => accumulatedSize.mainAxisExtent,
    };

    final constrainedSize = _AxisSize(
      mainAxisExtent: idealMainSize,
      crossAxisExtent: accumulatedSize.crossAxisExtent,
    ).applyConstraints(constraints, axis);

    return _LayoutSizes(
      axisSize: constrainedSize,
      mainAxisFreeSpace:
          constrainedSize.mainAxisExtent - accumulatedSize.mainAxisExtent,
      spacePerFlex: firstFlexChild == null ? null : spacePerFlex,
    );
  }

  double _getMainSize(OrbitalSize size) => switch (axis) {
    OrbitalAxis.radial => size.thickness,
    OrbitalAxis.angular => size.sweepAngle,
  };

  double _getCrossSize(OrbitalSize size) => switch (axis) {
    OrbitalAxis.radial => size.sweepAngle,
    OrbitalAxis.angular => size.thickness,
  };

  OrbitalConstraints _constraintsForNonFlexChild(
    OrbitalConstraints constraints,
  ) {
    final bool fillCrossAxis = switch (crossAxisAlignment) {
      CrossAxisAlignment.stretch => true,
      CrossAxisAlignment.start ||
      CrossAxisAlignment.center ||
      CrossAxisAlignment.end ||
      CrossAxisAlignment.baseline => false,
    };
    return switch (axis) {
      OrbitalAxis.radial =>
        fillCrossAxis
            ? OrbitalConstraints.tightFor(sweepAngle: constraints.maxSweepAngle)
            : OrbitalConstraints(maxSweepAngle: constraints.maxSweepAngle),
      OrbitalAxis.angular =>
        fillCrossAxis
            ? OrbitalConstraints.tightFor(thickness: constraints.maxThickness)
            : OrbitalConstraints(maxThickness: constraints.maxThickness),
    };
  }

  OrbitalConstraints _constraintsForFlexChild(
    RenderOrbital child,
    OrbitalConstraints constraints,
    double maxChildExtent,
  ) {
    assert(_getFlex(child) > 0.0);
    assert(maxChildExtent >= 0.0);
    final double minChildExtent = switch (_getFit(child)) {
      FlexFit.tight => maxChildExtent,
      FlexFit.loose => 0.0,
    };
    final bool fillCrossAxis = switch (crossAxisAlignment) {
      CrossAxisAlignment.stretch => true,
      CrossAxisAlignment.start ||
      CrossAxisAlignment.center ||
      CrossAxisAlignment.end ||
      CrossAxisAlignment.baseline => false,
    };
    return switch (axis) {
      OrbitalAxis.radial => OrbitalConstraints(
        minThickness: fillCrossAxis ? constraints.maxThickness : 0.0,
        maxThickness: constraints.maxThickness,
        minSweepAngle: minChildExtent,
        maxSweepAngle: maxChildExtent,
      ),
      OrbitalAxis.angular => OrbitalConstraints(
        minThickness: minChildExtent,
        maxThickness: maxChildExtent,
        minSweepAngle: fillCrossAxis ? constraints.maxSweepAngle : 0.0,
        maxSweepAngle: constraints.maxSweepAngle,
      ),
    };
  }

  (double leadingSpace, double betweenSpace) _distributeSpace({
    required MainAxisAlignment mainAxisAlignment,
    required double freeSpace,
    required int itemCount,
    required bool flipped,
    required double spacing,
  }) {
    assert(itemCount >= 0);
    return switch (mainAxisAlignment) {
      MainAxisAlignment.start =>
        flipped ? (freeSpace, spacing) : (0.0, spacing),

      MainAxisAlignment.end => _distributeSpace(
        mainAxisAlignment: MainAxisAlignment.start,
        freeSpace: freeSpace,
        itemCount: itemCount,
        flipped: !flipped,
        spacing: spacing,
      ),
      MainAxisAlignment.spaceBetween when itemCount < 2 => _distributeSpace(
        mainAxisAlignment: MainAxisAlignment.start,
        freeSpace: freeSpace,
        itemCount: itemCount,
        flipped: flipped,
        spacing: spacing,
      ),
      MainAxisAlignment.spaceAround when itemCount == 0 => _distributeSpace(
        mainAxisAlignment: MainAxisAlignment.start,
        freeSpace: freeSpace,
        itemCount: itemCount,
        flipped: flipped,
        spacing: spacing,
      ),
      MainAxisAlignment.center => (freeSpace / 2.0, spacing),
      MainAxisAlignment.spaceBetween => (
        0.0,
        freeSpace / (itemCount - 1) + spacing,
      ),
      MainAxisAlignment.spaceAround => (
        freeSpace / itemCount / 2,
        freeSpace / itemCount + spacing,
      ),
      MainAxisAlignment.spaceEvenly => (
        freeSpace / (itemCount + 1),
        freeSpace / (itemCount + 1) + spacing,
      ),
    };
  }

  double _getChildCrossAxisOffset({
    required CrossAxisAlignment crossAxisAlignment,
    required double freeSpace,
    required bool flipped,
  }) {
    // This method should not be used to position baseline-aligned children.
    return switch (crossAxisAlignment) {
      CrossAxisAlignment.stretch || CrossAxisAlignment.baseline => 0.0,
      CrossAxisAlignment.start => flipped ? freeSpace : 0.0,
      CrossAxisAlignment.center => freeSpace / 2,
      CrossAxisAlignment.end => _getChildCrossAxisOffset(
        crossAxisAlignment: CrossAxisAlignment.start,
        freeSpace: freeSpace,
        flipped: !flipped,
      ),
    };
  }

  static int _getFlex(RenderOrbital child) {
    final childParentData = child.parentData! as OrbitalFlexParentData;
    return childParentData.flex ?? 0;
  }

  static FlexFit _getFit(RenderOrbital child) {
    final childParentData = child.parentData! as OrbitalFlexParentData;
    return childParentData.fit ?? FlexFit.tight;
  }
}

/// Orbital equivalent of [FlexParentData].
class OrbitalFlexParentData<ChildType extends RenderOrbital>
    extends OrbitalParentData
    with ContainerParentDataMixin<ChildType> {
  OrbitalFlexParentData({
    required super.parentData,
    super.localOffset,
    this.flex,
    this.fit,
  });

  int? flex;
  FlexFit? fit;

  @override
  String toString() => '${super.toString()}; flex=$flex; fit=$fit';
}

@immutable
extension type const _AxisSize._(Size raw) {
  _AxisSize({required double mainAxisExtent, required double crossAxisExtent})
    : raw = Size(mainAxisExtent, crossAxisExtent);

  double get mainAxisExtent => raw.width;
  double get crossAxisExtent => raw.height;

  _AxisSize.fromOrbitalSize({
    required OrbitalSize size,
    required OrbitalAxis axis,
  }) : raw = switch (axis) {
         OrbitalAxis.angular => size.raw,
         OrbitalAxis.radial => size.raw.flipped,
       };

  OrbitalSize toOrbitalSize(OrbitalAxis axis) => OrbitalSize(
    sweepAngle: switch (axis) {
      OrbitalAxis.angular => mainAxisExtent,
      OrbitalAxis.radial => crossAxisExtent,
    },
    thickness: switch (axis) {
      OrbitalAxis.angular => crossAxisExtent,
      OrbitalAxis.radial => mainAxisExtent,
    },
  );

  _AxisSize applyConstraints(OrbitalConstraints constraints, OrbitalAxis axis) {
    return _AxisSize.fromOrbitalSize(
      size: constraints.constrain(toOrbitalSize(axis)),
      axis: axis,
    );
  }

  _AxisSize operator +(_AxisSize other) => _AxisSize(
    mainAxisExtent: mainAxisExtent + other.mainAxisExtent,
    crossAxisExtent: math.max(crossAxisExtent, other.crossAxisExtent),
  );
}

class _LayoutSizes {
  _LayoutSizes({
    required this.axisSize,
    required this.mainAxisFreeSpace,
    required this.spacePerFlex,
  }) : assert(spacePerFlex?.isFinite ?? true);

  /// The final constrained axis extent of the [RenderOrbitalFlex].
  final _AxisSize axisSize;

  /// The free space along the main axis. If the value is positive, the free
  /// space will be distributed according to the [MainAxisAlignment] specified.
  /// A negative value indicates the RenderFlex overflows along the main axis.
  final double mainAxisFreeSpace;

  /// The allocated space for flex children.
  final double? spacePerFlex;
}
