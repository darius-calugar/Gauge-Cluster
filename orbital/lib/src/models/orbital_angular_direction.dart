enum OrbitalAngularDirection {
  clockwise,
  counterclockwise;

  bool get isFlipped => switch (this) {
    OrbitalAngularDirection.clockwise => false,
    OrbitalAngularDirection.counterclockwise => true,
  };
}
