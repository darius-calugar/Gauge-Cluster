const _kmhToMphFactor = 1.609344;

extension type const Distance._(double _km) {
  const Distance.fromKm(double kmh) : this._(kmh);
  const Distance.fromMi(double mi) : this._(mi / _kmhToMphFactor);

  static const Distance zero = Distance._(0);
  static const Distance unit = Distance._(1);

  static Distance lerp(Distance a, Distance b, double t) => a + (b - a) * t;

  static Distance min(Distance a, Distance b) =>
      Distance._(a._km < b._km ? a._km : b._km);
  static Distance max(Distance a, Distance b) =>
      Distance._(a._km > b._km ? a._km : b._km);

  static double ratio(Distance a, Distance b) => a._km / b._km;

  Distance operator +(Distance other) => Distance._(_km + other._km);
  Distance operator -(Distance other) => Distance._(_km - other._km);
  Distance operator *(num other) => Distance._(_km * other);
  Distance operator /(num other) => Distance._(_km / other);
  Distance operator -() => Distance._(-_km);
  bool operator <(Distance other) => _km < other._km;
  bool operator <=(Distance other) => _km <= other._km;
  bool operator >(Distance other) => _km > other._km;
  bool operator >=(Distance other) => _km >= other._km;

  double get toKm => _km;
  double get toMi => _km / _kmhToMphFactor;
}

extension DistanceMathUtils on num {
  Distance get km => Distance.fromKm(toDouble());
  Distance get mi => Distance.fromMi(toDouble());
}
