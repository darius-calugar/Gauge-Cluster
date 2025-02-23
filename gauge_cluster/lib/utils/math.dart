import 'dart:math';

const _toRadFactor = pi / 180;

extension type const Angle._(double _radians) implements double {
  const Angle.fromRad(double value) : this._(value);
  const Angle.fromDeg(double value) : this._(value * _toRadFactor);

  static const Angle zero = Angle.fromRad(0);
  static const Angle quarter = Angle.fromRad(pi / 2);
  static const Angle half = Angle.fromRad(pi);
  static const Angle full = Angle.fromRad(2 * pi);

  static const Angle right = Angle.fromRad(0);
  static const Angle down = Angle.fromRad(pi / 2);
  static const Angle left = Angle.fromRad(pi);
  static const Angle up = Angle.fromRad(3 * pi / 2);

  static Angle lerp(Angle a, Angle b, double t) => a + (b - a) * t;

  Angle operator +(Angle other) => Angle.fromRad(_radians + other);
  Angle operator -(Angle other) => Angle.fromRad(_radians - other);
  Angle operator *(num other) => Angle.fromRad(_radians * other);
  Angle operator /(num other) => Angle.fromRad(_radians / other);
  Angle operator -() => Angle.fromRad(-_radians);
}

extension MathUtils on num {
  Angle get rad => Angle.fromRad(toDouble());
  Angle get deg => Angle.fromDeg(toDouble());
}
