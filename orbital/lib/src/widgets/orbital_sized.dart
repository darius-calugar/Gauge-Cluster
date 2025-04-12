import 'package:flutter/widgets.dart';
import 'package:orbital/orbital.dart';

class OrbitalSized extends SingleChildRenderObjectWidget {
  const OrbitalSized({super.key, super.child, this.thickness, this.sweepAngle});

  final double? thickness;
  final double? sweepAngle;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderOrbitalConstrained(
        additionalConstraints: OrbitalConstraints.tightFor(
          thickness: thickness,
          sweepAngle: sweepAngle,
        ),
      );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderOrbitalConstrained renderObject,
  ) =>
      renderObject.additionalConstraints = OrbitalConstraints.tightFor(
        thickness: thickness,
        sweepAngle: sweepAngle,
      );
}
