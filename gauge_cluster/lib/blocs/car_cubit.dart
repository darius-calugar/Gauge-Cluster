import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  CarCubit() : super(CarState.initial());

  void setSpeed(double speed) async {
    emit(state.copyWith(speed: speed));
  }

  void setRevs(double revs) async {
    emit(state.copyWith(revs: revs));
  }

  void setMileage(int mileage) async {
    emit(state.copyWith(mileage: mileage));
  }

  void shiftTo(int gear) async {
    emit(state.copyWith(gear: gear));
  }

  void shiftUp() async {
    emit(state.copyWith(gear: state.gear + 1));
  }

  void shiftDown() async {
    emit(state.copyWith(gear: state.gear - 1));
  }

  void setFuel(double fuel) async {
    emit(state.copyWith(fuel: fuel));
  }

  void setTemperature(double temperature) async {
    emit(state.copyWith(temperature: temperature));
  }

  void toggleLeftTurnSignal() async {
    emit(state.copyWith(leftTurnSignal: !state.leftTurnSignal));
  }

  void toggleRightTurnSignal() async {
    emit(state.copyWith(rightTurnSignal: !state.rightTurnSignal));
  }

  void toggleDoorSignal() async {
    emit(state.copyWith(doorSignal: !state.doorSignal));
  }

  void toggleBrakesSignal() async {
    emit(state.copyWith(brakesSignal: !state.brakesSignal));
  }

  void toggleBatterySignal() async {
    emit(state.copyWith(batterySignal: !state.batterySignal));
  }

  void toggleTransmissionSignal() async {
    emit(state.copyWith(transmissionSignal: !state.transmissionSignal));
  }

  void toggleEngineSignal() async {
    emit(state.copyWith(engineSignal: !state.engineSignal));
  }

  void toggleServiceSignal() async {
    emit(state.copyWith(serviceSignal: !state.serviceSignal));
  }
}
