import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_fill.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_shape.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';
import 'package:gauge_cluster/utils/math/circle/circle_ring.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class PinPart extends CompositeGaugePart {
  PinPart({
    required double outerInset,
    required double knobRadius,
    required Angle angle,
  }) : super(
         parts: [
           // Knob
           GaugePart(
             shape: GaugePartSectorShape(outerRadius: knobRadius),
             fill: GaugePartRadialGradientFill(
               ring: CircleRing(
                 circle: Circle(radius: 300),
                 thickness: knobRadius * 2,
               ),
               colors: [AppColors.black3, AppColors.black2],
             ),
             shadow: Shadow(color: AppColors.black1, blurRadius: 8),
           ),
           GaugePart(
             shape: GaugePartSectorShape(outerRadius: knobRadius, thickness: 1),
             fill: GaugePartSolidFill(color: AppColors.black3),
             shadow: Shadow(color: AppColors.black1, blurRadius: 8),
           ),
           // Pin
           GaugePart(
             shape: GaugePartRectShape.inset(
               innerInset: knobRadius,
               outerInset: outerInset,
               width: 3,
               angle: angle,
             ),
             fill: GaugePartLinearGradientFill(
               colors: [AppColors.red2, AppColors.red1],
             ),
           ),
         ],
       );
}
