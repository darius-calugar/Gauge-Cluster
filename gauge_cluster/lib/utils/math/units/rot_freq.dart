extension type const RotFreq._(double _rpm) {
  const RotFreq.fromRpm(double value) : this._(value);

  static const RotFreq zero = RotFreq._(0);
  static const RotFreq unit = RotFreq._(1000);

  static RotFreq lerp(RotFreq a, RotFreq b, double t) => a + (b - a) * t;

  static RotFreq min(RotFreq a, RotFreq b) =>
      RotFreq._(a._rpm < b._rpm ? a._rpm : b._rpm);
  static RotFreq max(RotFreq a, RotFreq b) =>
      RotFreq._(a._rpm > b._rpm ? a._rpm : b._rpm);
  static RotFreq clamp(RotFreq value, RotFreq min, RotFreq max) =>
      RotFreq._(value._rpm.clamp(min._rpm, max._rpm));

  static double ratio(RotFreq a, RotFreq b) => a._rpm / b._rpm;

  RotFreq operator +(RotFreq other) => RotFreq._(_rpm + other._rpm);
  RotFreq operator -(RotFreq other) => RotFreq._(_rpm - other._rpm);
  RotFreq operator *(num other) => RotFreq._(_rpm * other);
  RotFreq operator /(num other) => RotFreq._(_rpm / other);
  RotFreq operator -() => RotFreq._(-_rpm);
  bool operator <(RotFreq other) => _rpm < other._rpm;
  bool operator <=(RotFreq other) => _rpm <= other._rpm;
  bool operator >(RotFreq other) => _rpm > other._rpm;
  bool operator >=(RotFreq other) => _rpm >= other._rpm;

  double get toRpm => _rpm;
}

extension RotFreqUtils on num {
  RotFreq get rpm => RotFreq.fromRpm(toDouble());
}
