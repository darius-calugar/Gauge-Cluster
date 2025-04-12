import 'dart:math' as math;
import 'dart:ui';

import 'package:orbital/orbital.dart';

extension OrbitalPathExtension on Path {
  void addSector(OrbitalSector sector) {
    final innerRect =
        Offset(sector.thickness, sector.thickness) &
        Size.square(sector.inner * 2);
    final outerRect = Offset.zero & Size.square(sector.outer * 2);

    final innerPath =
        sector.sweep == 2 * math.pi ? (Path()..addOval(innerRect)) : Path()
          ..moveTo(innerRect.center.dx, innerRect.center.dy)
          ..arcTo(innerRect, sector.start, sector.sweep, false)
          ..close();
    final outerPath =
        sector.sweep == 2 * math.pi ? (Path()..addOval(outerRect)) : Path()
          ..moveTo(outerRect.center.dx, outerRect.center.dy)
          ..arcTo(outerRect, sector.end, -sector.sweep, false)
          ..close();
    final path = Path.combine(PathOperation.difference, outerPath, innerPath);

    addPath(path, Offset.zero);
  }
}
