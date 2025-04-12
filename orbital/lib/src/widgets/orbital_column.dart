import 'package:flutter/cupertino.dart';
import 'package:orbital/orbital.dart';

/// Orbital equivalent for the [Column] widget.
class OrbitalColumn extends OrbitalFlex {
  const OrbitalColumn({
    super.key,
    super.children,
    super.radialDirection,
    super.angularDirection,
    super.mainAxisSize,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.spacing,
  }) : super(axis: OrbitalAxis.radial);
}
