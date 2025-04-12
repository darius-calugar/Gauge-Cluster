import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orbital/orbital.dart';

// Data used by the DebugOverflowIndicator to manage the regions and labels for
// the indicators.
class _OverflowRegionData {
  const _OverflowRegionData({required this.sector, required this.axis});

  final OrbitalSector sector;
  final OrbitalAxis axis;
}

/// Orbital equivalent of [DebugOverflowIndicatorMixin].
mixin DebugOrbitalOverflowIndicatorMixin on RenderOrbital {
  static const _black = Color(0xBF000000);
  static const _yellow = Color(0xBFFFFF00);
  // The fraction of the sector that the indicator covers.
  static const _indicatorFraction = 0.1;

  // Set to true to trigger a debug message in the console upon
  // the next paint call. Will be reset after each paint.
  bool _overflowReportNeeded = true;

  String _formatPixels(double value) {
    assert(value > 0.0);
    return switch (value) {
      > 10.0 => value.toStringAsFixed(0),
      > 1.0 => value.toStringAsFixed(1),
      _ => value.toStringAsPrecision(3),
    };
  }

  List<_OverflowRegionData> _calculateOverflowRegions(
    OrbitalSector overflow,
    OrbitalSector containerRect,
  ) {
    final indicatorThickness = _indicatorFraction * containerRect.thickness;
    final regions = <_OverflowRegionData>[];
    if (overflow.start > 0.0) {
      regions.add(
        _OverflowRegionData(
          axis: OrbitalAxis.angular,
          sector: OrbitalSector.fromSEIO(
            containerRect.start,
            containerRect.start + .25,
            containerRect.inner,
            containerRect.outer,
          ),
        ),
      );
    }
    if (overflow.end > 0.0) {
      regions.add(
        _OverflowRegionData(
          axis: OrbitalAxis.angular,
          sector: OrbitalSector.fromSEIO(
            containerRect.end - .25,
            containerRect.end,
            containerRect.inner,
            containerRect.outer,
          ),
        ),
      );
    }
    if (overflow.inner > 0.0) {
      regions.add(
        _OverflowRegionData(
          axis: OrbitalAxis.radial,
          sector: OrbitalSector.fromSEIO(
            containerRect.start,
            containerRect.end,
            containerRect.inner,
            containerRect.inner + indicatorThickness,
          ),
        ),
      );
    }
    if (overflow.outer > 0.0) {
      regions.add(
        _OverflowRegionData(
          axis: OrbitalAxis.radial,
          sector: OrbitalSector.fromSEIO(
            containerRect.start,
            containerRect.end,
            containerRect.outer - indicatorThickness,
            containerRect.outer,
          ),
        ),
      );
    }
    return regions;
  }

  void _reportOverflow(
    OrbitalSector overflow,
    List<DiagnosticsNode>? overflowHints,
  ) {
    overflowHints ??= <DiagnosticsNode>[];
    if (overflowHints.isEmpty) {
      overflowHints.add(
        ErrorDescription(
          'The edge of the $runtimeType that is '
          'overflowing has been marked in the rendering with a yellow and black '
          'striped pattern. This is usually caused by the contents being too big '
          'for the $runtimeType.',
        ),
      );
      overflowHints.add(
        ErrorHint(
          'This is considered an error condition because it indicates that there '
          'is content that cannot be seen. If the content is legitimately bigger '
          'than the available space, consider clipping it with a ClipRect widget '
          'before putting it in the $runtimeType, or using a scrollable '
          'container, like a ListView.',
        ),
      );
    }

    final List<String> overflows = <String>[
      if (overflow.start > 0.0)
        '${_formatPixels(overflow.start)} radians on the start',
      if (overflow.end > 0.0)
        '${_formatPixels(overflow.end)} radians on the end',
      if (overflow.inner > 0.0)
        '${_formatPixels(overflow.inner)} pixels on the inner',
      if (overflow.outer > 0.0)
        '${_formatPixels(overflow.outer)} pixels on the outer',
    ];
    String overflowText = '';
    assert(
      overflows.isNotEmpty,
      "Somehow $runtimeType didn't actually overflow like it thought it did.",
    );
    switch (overflows.length) {
      case 1:
        overflowText = overflows.first;
      case 2:
        overflowText = '${overflows.first} and ${overflows.last}';
      default:
        overflows[overflows.length - 1] =
            'and ${overflows[overflows.length - 1]}';
        overflowText = overflows.join(', ');
    }
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: FlutterError('A $runtimeType overflowed by $overflowText.'),
        library: 'rendering library',
        context: ErrorDescription('during layout'),
        informationCollector:
            () => <DiagnosticsNode>[
              // debugCreator should only be set in DebugMode, but we want the
              // treeshaker to know that.
              if (kDebugMode && debugCreator != null)
                DiagnosticsDebugCreator(debugCreator!),
              ...overflowHints!,
              describeForError('The specific $runtimeType in question is'),
              DiagnosticsNode.message(
                '◢◤' * (FlutterError.wrapWidth ~/ 2),
                allowWrap: false,
              ),
            ],
      ),
    );
  }

  /// To be called when the overflow indicators should be painted.
  ///
  /// Typically only called if there is an overflow, and only from within a
  /// debug build.
  ///
  /// See example code in [DebugOrbitalOverflowIndicatorMixin] documentation.
  void paintOverflowIndicator(
    PaintingContext context,
    Offset offset,
    OrbitalSector containerSector,
    OrbitalSector childSector, {
    List<DiagnosticsNode>? overflowHints,
  }) {
    final OrbitalSector overflow = OrbitalSector.fromSEIO(
      containerSector.start - childSector.start,
      childSector.end - containerSector.end,
      containerSector.inner - childSector.inner,
      childSector.outer - containerSector.outer,
    );

    if (overflow.start <= 0 &&
        overflow.end <= 0 &&
        overflow.inner <= 0 &&
        overflow.outer <= 0) {
      return;
    }

    final List<_OverflowRegionData> overflowRegions = _calculateOverflowRegions(
      overflow,
      containerSector,
    );
    for (final _OverflowRegionData region in overflowRegions) {
      final indicatorPaint = switch (region.axis) {
        OrbitalAxis.angular =>
          Paint()
            ..shader = ui.Gradient.radial(
              offset + Offset(containerSector.outer, containerSector.outer),
              10,
              <Color>[_black, _yellow, _yellow, _black],
              <double>[0.25, 0.25, 0.75, 0.75],
              TileMode.repeated,
            ),
        OrbitalAxis.radial =>
          Paint()
            ..shader = ui.Gradient.sweep(
              offset + Offset(containerSector.outer, containerSector.outer),
              <Color>[_black, _yellow, _yellow, _black],
              <double>[0.25, 0.25, 0.75, 0.75],
              TileMode.repeated,
              0,
              .1,
            ),
      };
      final outerRadiusDelta = containerSector.outer - region.sector.outer;
      final localOffset = Offset(outerRadiusDelta, outerRadiusDelta);
      final indicatorPath = region.sector.toPath().shift(offset + localOffset);
      context.canvas.drawPath(indicatorPath, indicatorPaint);

      final containerPath = containerSector.toPath().shift(offset);
      final strokePaint =
          Paint()
            ..color = _yellow
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1;

      context.canvas.drawPath(containerPath, strokePaint);
    }

    if (_overflowReportNeeded) {
      _overflowReportNeeded = false;
      _reportOverflow(overflow, overflowHints);
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    // Users expect error messages to be shown again after hot reload.
    assert(() {
      _overflowReportNeeded = true;
      return true;
    }());
  }
}
