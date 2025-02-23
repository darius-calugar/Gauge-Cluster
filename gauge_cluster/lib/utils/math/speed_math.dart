const _kmhToMphFactor = 1.609344;

extension type const Speed._(double _kmh) {
  const Speed.fromKmh(double kmh) : this._(kmh);
  const Speed.fromMph(double mph) : this._(mph * _kmhToMphFactor);

  static const Speed zero = Speed._(0);
  static const Speed unit = Speed._(20);

  static Speed lerp(Speed a, Speed b, double t) => a + (b - a) * t;

  static Speed min(Speed a, Speed b) =>
      Speed._(a._kmh < b._kmh ? a._kmh : b._kmh);
  static Speed max(Speed a, Speed b) =>
      Speed._(a._kmh > b._kmh ? a._kmh : b._kmh);

  static double ratio(Speed a, Speed b) => a._kmh / b._kmh;

  Speed operator +(Speed other) => Speed._(_kmh + other._kmh);
  Speed operator -(Speed other) => Speed._(_kmh - other._kmh);
  Speed operator *(num other) => Speed._(_kmh * other);
  Speed operator /(num other) => Speed._(_kmh / other);
  Speed operator -() => Speed._(-_kmh);
  bool operator <(Speed other) => _kmh < other._kmh;
  bool operator <=(Speed other) => _kmh <= other._kmh;
  bool operator >(Speed other) => _kmh > other._kmh;
  bool operator >=(Speed other) => _kmh >= other._kmh;

  double get toKmh => _kmh;
  double get toMph => _kmh / _kmhToMphFactor;
}

extension SpeedMathUtils on num {
  Speed get kmh => Speed.fromKmh(toDouble());
  Speed get mph => Speed.fromMph(toDouble());
}
