import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orbital/orbital.dart';

class OrbitalDebugGaugeCluster extends StatelessWidget {
  const OrbitalDebugGaugeCluster({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 800,
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          _DebugBox(
            child: OrbitalLayout(
              child: OrbitalPadding(
                padding: OrbitalEdgeInsets.only(inner: 100),
                child: OrbitalPlaceholder(),
              ),
            ),
          ),
          _DebugBox(
            child: OrbitalLayout(
              child: OrbitalPadding(
                padding: OrbitalEdgeInsets.only(inner: 10, outer: 10),
                child: OrbitalSized(
                  thickness: 40,
                  sweepAngle: 2 / 3 * pi,
                  child: OrbitalPlaceholder(),
                ),
              ),
            ),
          ),
          _DebugBox(
            child: OrbitalLayout(
              child: OrbitalPadding(
                padding: OrbitalEdgeInsets.only(inner: 50),
                child: OrbitalRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    OrbitalSized(
                      thickness: 50,
                      sweepAngle: 1,
                      child: OrbitalPlaceholder(),
                    ),
                    OrbitalSized(
                      thickness: 60,
                      sweepAngle: 1,
                      child: OrbitalPlaceholder(),
                    ),
                    OrbitalSized(
                      thickness: 70,
                      sweepAngle: 1,
                      child: OrbitalPlaceholder(),
                    ),
                    OrbitalSized(
                      thickness: 80,
                      sweepAngle: 1,
                      child: OrbitalPlaceholder(),
                    ),
                    OrbitalSized(
                      thickness: 90,
                      sweepAngle: 1,
                      child: OrbitalPlaceholder(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _DebugBox(
            child: OrbitalLayout(
              child: OrbitalPadding(
                padding: OrbitalEdgeInsets.only(inner: 50, start: 1),
                child: OrbitalColumn(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrbitalSized(
                      thickness: 30,
                      sweepAngle: 1,
                      child: OrbitalPlaceholder(),
                    ),
                    OrbitalSized(
                      thickness: 40,
                      sweepAngle: 2,
                      child: OrbitalPlaceholder(),
                    ),
                    OrbitalSized(
                      thickness: 50,
                      sweepAngle: 3,
                      child: OrbitalPlaceholder(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DebugBox extends StatelessWidget {
  const _DebugBox({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      position: DecorationPosition.background,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Center(
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            shape: BoxShape.circle,
          ),
          child: DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
