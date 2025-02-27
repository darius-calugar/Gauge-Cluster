import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_fill.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_shape.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class PinPart extends CompositeGaugePart {
  PinPart({
    required double outerInset,
    required double knobRadius,
    required Angle angle,
  }) : super(
         parts: [
           // Pin
           GaugePart(
             shape: GaugePartRectShape.inset(
               innerInset: knobRadius,
               outerInset: outerInset,
               width: 3,
               angle: angle,
             ),
             fill: GaugePartLinearGradientFill(
               colors: [AppColors.red7, AppColors.red5],
             ),
             shadow: Shadow(color: AppColors.red7, blurRadius: 4),
           ),
           // Knob
           GaugePart(
             shape: GaugePartSectorShape(outerRadius: knobRadius),
             fill: GaugePartRadialGradientFill(
               colors: [AppColors.black4, AppColors.black3],
               stops: [0.3, 1],
             ),
             shadow: Shadow(color: AppColors.black1, blurRadius: 8),
           ),
           GaugePart(
             shape: GaugePartSectorShape(outerRadius: knobRadius, thickness: 1),
             fill: GaugePartSolidFill(color: AppColors.black4),
           ),
         ],
       );
}
