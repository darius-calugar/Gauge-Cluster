enum OrbitalRadialDirection {
  outwards,
  inwards;

  bool get isFlipped => switch (this) {
    OrbitalRadialDirection.outwards => false,
    OrbitalRadialDirection.inwards => true,
  };
}
