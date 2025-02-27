import 'package:gauge_cluster/components/gauge_v2/models/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_fill.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_shape.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_shadow.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/utils/math/circle/circle_line.dart';
import 'package:gauge_cluster/utils/math/circle/circle_point.dart';
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
             shadows: [
               GaugeShadow(
                 color: AppColors.black1,
                 blurRadius: 4,
                 offset: CirclePoint(radius: 6, angle: 120.deg),
               ),
               GaugeShadow(color: AppColors.red7, blurRadius: 4),
             ],
           ),
           // Knob
           GaugePart(
             shape: GaugePartSectorShape(outerRadius: knobRadius),
             fill: GaugePartRadialGradientFill(
               colors: [AppColors.black4, AppColors.black3],
               stops: [0.3, 1],
             ),
             shadows: [
               GaugeShadow(
                 color: AppColors.black1,
                 blurRadius: 8,
                 offset: CirclePoint(radius: 4, angle: 120.deg),
               ),
             ],
           ),
           GaugePart(
             shape: GaugePartSectorShape(outerRadius: knobRadius, thickness: 1),
             fill: GaugePartSolidFill(color: AppColors.black4),
           ),
           GaugePart(
             shape: GaugePartSectorShape(outerRadius: knobRadius),
             fill: GaugePartLinearGradientFill(
               line: CircleLine(
                 start: CirclePoint(
                   radius: knobRadius,
                   angle: Angle.bottomLeft,
                 ),
                 end: CirclePoint(radius: knobRadius, angle: Angle.topRight),
               ),
               colors: [AppColors.black4.transparent, AppColors.black4],
             ),
           ),
         ],
       );
}
