part of 'car_cubit.dart';

class CarState extends Equatable {
  const CarState({
    required this.maxSpeed,
    required this.speed,
    required this.maxRevs,
    required this.revs,
    required this.redline,
    required this.mileage,
    required this.gear,
    required this.fuel,
    required this.temperature,
    required this.leftTurnSignal,
    required this.rightTurnSignal,
    required this.doorSignal,
    required this.brakesSignal,
    required this.batterySignal,
    required this.transmissionSignal,
    required this.engineSignal,
    required this.serviceSignal,
  });

  const CarState.initial()
    : maxSpeed = const Speed.fromKmh(260),
      speed = Speed.zero,
      maxRevs = const RotFreq.fromRpm(7000),
      revs = RotFreq.zero,
      redline = const RotFreq.fromRpm(5000),
      mileage = Distance.zero,
      gear = 0,
      fuel = 1,
      temperature = 0.5,
      leftTurnSignal = false,
      rightTurnSignal = false,
      doorSignal = false,
      brakesSignal = false,
      batterySignal = false,
      transmissionSignal = false,
      engineSignal = false,
      serviceSignal = false;

  final int minGears = -1;
  final int maxGears = 6;

  final Speed maxSpeed;
  final Speed speed;
  final RotFreq maxRevs;
  final RotFreq revs;
  final RotFreq redline;
  final Distance mileage;
  final int gear;
  final double fuel;
  final double temperature;
  final bool leftTurnSignal;
  final bool rightTurnSignal;
  final bool doorSignal;
  final bool brakesSignal;
  final bool batterySignal;
  final bool transmissionSignal;
  final bool engineSignal;
  final bool serviceSignal;

  double get speedRatio => Speed.ratio(speed, maxSpeed);
  double get revsRatio => RotFreq.ratio(revs, maxRevs);
  double get redlineRatio => RotFreq.ratio(redline, maxRevs);
  bool get fuelSignal => fuel < .1;
  bool get temperatureSignal => temperature > .9;

  CarState copyWith({
    Speed? maxSpeed,
    Speed? speed,
    RotFreq? maxRevs,
    RotFreq? revs,
    RotFreq? redline,
    Distance? mileage,
    int? gear,
    double? fuel,
    double? temperature,
    bool? leftTurnSignal,
    bool? rightTurnSignal,
    bool? doorSignal,
    bool? brakesSignal,
    bool? batterySignal,
    bool? transmissionSignal,
    bool? engineSignal,
    bool? serviceSignal,
  }) => CarState(
    maxSpeed: maxSpeed ?? this.maxSpeed,
    speed: speed ?? this.speed,
    maxRevs: maxRevs ?? this.maxRevs,
    revs: revs ?? this.revs,
    redline: redline ?? this.redline,
    mileage: mileage ?? this.mileage,
    gear: gear ?? this.gear,
    fuel: fuel ?? this.fuel,
    temperature: temperature ?? this.temperature,
    leftTurnSignal: leftTurnSignal ?? this.leftTurnSignal,
    rightTurnSignal: rightTurnSignal ?? this.rightTurnSignal,
    doorSignal: doorSignal ?? this.doorSignal,
    brakesSignal: brakesSignal ?? this.brakesSignal,
    batterySignal: batterySignal ?? this.batterySignal,
    transmissionSignal: transmissionSignal ?? this.transmissionSignal,
    engineSignal: engineSignal ?? this.engineSignal,
    serviceSignal: serviceSignal ?? this.serviceSignal,
  );

  @override
  List<Object?> get props => [
    maxSpeed,
    speed,
    maxRevs,
    revs,
    redline,
    mileage,
    gear,
    fuel,
    temperature,
    leftTurnSignal,
    rightTurnSignal,
    doorSignal,
    brakesSignal,
    batterySignal,
    transmissionSignal,
    engineSignal,
    serviceSignal,
  ];
}
