part of 'car_cubit.dart';

class CarState extends Equatable {
  const CarState({
    required this.speed,
    required this.revs,
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
      : speed = 0,
        revs = 0,
        mileage = 0,
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

  final double speed;
  final double revs;
  final int mileage;
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

  bool get fuelSignal => fuel < .1;
  bool get temperatureSignal => temperature > .9;

  CarState copyWith({
    double? speed,
    double? revs,
    int? mileage,
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
  }) =>
      CarState(
        speed: speed ?? this.speed,
        revs: revs ?? this.revs,
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
        speed,
        revs,
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
