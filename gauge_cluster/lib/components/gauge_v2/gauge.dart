import 'package:flutter/widgets.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part.dart';
import 'package:gauge_cluster/components/gauge_v2/models/gauge_part_shape.dart';
import 'package:gauge_cluster/components/gauge_v2/widgets/gauge_part_point_shape_widget.dart';
import 'package:gauge_cluster/components/gauge_v2/widgets/gauge_part_rect_shape_widget.dart';
import 'package:gauge_cluster/components/gauge_v2/widgets/gauge_part_sector_shape_widget.dart';

export 'package:gauge_cluster/components/gauge_v2/models/gauge_part_decoration.dart';
export 'package:gauge_cluster/components/gauge_v2/models/gauge_part_shape.dart';
export 'package:gauge_cluster/components/gauge_v2/models/gauge_part.dart';

class Gauge extends StatelessWidget {
  const Gauge({super.key, required this.parts});

  final List<GaugePart> parts;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final circleDiameter = constraints.biggest.shortestSide;
        final circleRadius = circleDiameter / 2;

        return SizedBox.square(
          dimension: circleDiameter,
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              for (final part in parts)
                switch (part.shape) {
                  GaugePartPointShape() => GaugePartPointShapeWidget(
                    part: part,
                    circleRadius: circleRadius,
                  ),
                  GaugePartSectorShape() => GaugePartSectorShapeWidget(
                    part: part,
                    circleRadius: circleRadius,
                  ),
                  GaugePartRectShape() => GaugePartRectShapeWidget(
                    part: part,
                    circleRadius: circleRadius,
                  ),
                },
            ],
          ),
        );
      },
    );
  }
}
