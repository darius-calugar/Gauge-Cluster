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
           // Knob base
           GaugePart(
             shape: GaugePartSectorShape(outerRadius: knobRadius + 4),
             fill: GaugePartSolidFill(color: AppColors.black2),
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
           // Knob
           GaugePart(
             shape: GaugePartSectorShape(outerRadius: knobRadius),
             fill: GaugePartSolidFill(color: AppColors.black3),
           ),
         ],
       );
}
