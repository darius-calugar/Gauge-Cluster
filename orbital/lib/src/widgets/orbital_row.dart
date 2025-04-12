import 'package:flutter/cupertino.dart';
import 'package:orbital/orbital.dart';

/// Orbital equivalent for the [Row] widget.
class OrbitalRow extends OrbitalFlex {
  const OrbitalRow({
    super.key,
    super.children,
    super.radialDirection,
    super.angularDirection,
    super.mainAxisSize,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.spacing,
  }) : super(axis: OrbitalAxis.angular);
}
