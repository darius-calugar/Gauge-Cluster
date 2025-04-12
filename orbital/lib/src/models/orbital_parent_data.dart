import 'package:flutter/rendering.dart';
import 'package:orbital/src/models/math/orbital_offset.dart';

class OrbitalParentData extends ParentData {
  OrbitalParentData({
    required this.parentData,
    this.localOffset = OrbitalOffset.zero,
  });

  OrbitalParentData? parentData;
  OrbitalOffset localOffset;

  OrbitalOffset get offset =>
      (parentData?.offset ?? OrbitalOffset.zero) + localOffset;

  @override
  String toString() => 'offset=$offset';
}
