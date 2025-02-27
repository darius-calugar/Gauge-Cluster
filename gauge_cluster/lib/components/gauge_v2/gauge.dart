import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_shape.dart';
import 'package:gauge_cluster/components/gauge_v2/widgets/gauge_part_point_shape_widget.dart';
import 'package:gauge_cluster/components/gauge_v2/widgets/gauge_part_rect_shape_widget.dart';
import 'package:gauge_cluster/components/gauge_v2/widgets/gauge_part_sector_shape_widget.dart';
import 'package:gauge_cluster/utils/math/circle/circle.dart';

export 'package:gauge_cluster/components/gauge_v2/models/gauge_part_fill.dart';
export 'package:gauge_cluster/components/gauge_v2/models/gauge_part_shape.dart';
export 'package:gauge_cluster/components/gauge_v2/models/gauge_part.dart';

class Gauge extends StatelessWidget {
  const Gauge({super.key, required this.circle, required this.parts});

  final Circle circle;
  final List<BaseGaugePart> parts;

  @override
  Widget build(BuildContext context) {
    final flatParts = [
      for (final part in parts)
        ...switch (part) {
          GaugePart() => [part],
          CompositeGaugePart() => part.parts,
        },
    ];

    return Center(
      child: SizedBox.square(
        dimension: circle.diameter,
        child: Stack(
          alignment: Alignment.center,
          children: [
            for (final part in flatParts)
              switch (part.shape) {
                GaugePartPointShape() => GaugePartPointShapeWidget(
                  circle: circle,
                  part: part,
                ),
                GaugePartRectShape() => GaugePartRectShapeWidget(
                  circle: circle,
                  part: part,
                ),
                GaugePartSectorShape() => GaugePartSectorShapeWidget(
                  circle: circle,
                  part: part,
                ),
              },
          ],
        ),
      ),
    );
  }
}
