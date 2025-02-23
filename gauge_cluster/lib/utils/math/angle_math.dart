import 'dart:math';

const _degToRadFactor = pi / 180;

extension type const Angle._(double _rad) {
  const Angle.fromRad(double rad) : this._(rad);
  const Angle.fromDeg(double deg) : this._(deg * _degToRadFactor);

  static const Angle zero = Angle.fromRad(0);
  static const Angle quarter = Angle.fromRad(pi / 2);
  static const Angle half = Angle.fromRad(pi);
  static const Angle full = Angle.fromRad(2 * pi);

  static const Angle right = Angle.fromRad(0);
  static const Angle down = Angle.fromRad(pi / 2);
  static const Angle left = Angle.fromRad(pi);
  static const Angle up = Angle.fromRad(3 * pi / 2);

  static Angle lerp(Angle a, Angle b, double t) => a + (b - a) * t;

  static Angle min(Angle a, Angle b) =>
      Angle.fromRad(a._rad < b._rad ? a._rad : b._rad);
  static Angle max(Angle a, Angle b) =>
      Angle.fromRad(a._rad > b._rad ? a._rad : b._rad);
  static Angle clamp(Angle value, Angle min, Angle max) =>
      Angle.fromRad(value._rad.clamp(min._rad, max._rad));

  static double ratio(Angle a, Angle b) => a._rad / b._rad;

  Angle operator +(Angle other) => Angle.fromRad(_rad + other._rad);
  Angle operator -(Angle other) => Angle.fromRad(_rad - other._rad);
  Angle operator *(num other) => Angle.fromRad(_rad * other);
  Angle operator /(num other) => Angle.fromRad(_rad / other);
  Angle operator -() => Angle.fromRad(-_rad);
  bool operator <(Angle other) => _rad < other._rad;
  bool operator <=(Angle other) => _rad <= other._rad;
  bool operator >(Angle other) => _rad > other._rad;
  bool operator >=(Angle other) => _rad >= other._rad;

  double get toRad => _rad;
  double get toDeg => _rad / _degToRadFactor;
}

extension AngleMathUtils on num {
  Angle get rad => Angle.fromRad(toDouble());
  Angle get deg => Angle.fromDeg(toDouble());
}
