import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:orbital/src/models/math/orbital_constraints.dart';
import 'package:orbital/src/models/math/orbital_sector.dart';
import 'package:orbital/src/models/orbital_parent_data.dart';
import 'package:orbital/src/models/math/orbital_size.dart';

abstract class RenderOrbital extends RenderObject {
  @override
  OrbitalConstraints get constraints => super.constraints as OrbitalConstraints;

  Rect get bounds {
    final parentData = super.parentData as OrbitalParentData;
    final outerRadius = parentData.offset.dr + size.thickness;
    return Offset.zero & Size.square(outerRadius * 2);
  }

  @override
  Rect get paintBounds => bounds;

  @override
  Rect get semanticBounds => bounds;

  @override
  void setupParentData(covariant RenderObject child) {
    final parentData = this.parentData as OrbitalParentData;
    if (child.parentData is! OrbitalParentData) {
      child.parentData = OrbitalParentData(parentData: parentData);
    }
  }

  @override
  void performLayout() {
    assert(sizedByParent);
  }

  @override
  @nonVirtual
  void performResize() {
    size = computeDryLayout();
  }

  @visibleForOverriding
  @protected
  OrbitalSize computeDryLayout() => constraints.smallest;

  @override
  void debugAssertDoesMeetConstraints() {
    assert(() {
      if (hasSize) {
        assert(constraints.minThickness <= size.thickness);
        assert(size.thickness <= constraints.maxThickness);
        assert(constraints.minSweepAngle <= size.sweepAngle);
        assert(size.sweepAngle <= constraints.maxSweepAngle);
      }
      return true;
    }());
  }

  bool get hasSize => _size != null;

  OrbitalSize get size => _size!;

  OrbitalSector get sector => (parentData as OrbitalParentData).offset & size;

  double get innerRadius => (parentData as OrbitalParentData).offset.dr;
  double get outerRadius => innerRadius + size.thickness;
  double get startAngle => (parentData as OrbitalParentData).offset.da;
  double get endAngle => startAngle + size.sweepAngle;

  @protected
  set size(OrbitalSize value) {
    _size = value;
    assert(() {
      debugAssertDoesMeetConstraints();
      return true;
    }());
  }

  OrbitalSize? _size;
}
