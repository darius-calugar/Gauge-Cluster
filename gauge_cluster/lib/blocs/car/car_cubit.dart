import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/utils/math/distance_math.dart';
import 'package:gauge_cluster/utils/math/rot_freq_math.dart';
import 'package:gauge_cluster/utils/math/speed_math.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  CarCubit() : super(CarState.initial());

  void setMaxSpeed(Speed maxSpeed) async {
    emit(
      state.copyWith(
        maxSpeed: maxSpeed,
        speed: Speed.min(state.speed, maxSpeed),
      ),
    );
  }

  void setSpeed(Speed speed) async {
    emit(state.copyWith(speed: speed));
  }

  void setMaxRevs(RotFreq maxRevs) async {
    emit(
      state.copyWith(
        maxRevs: maxRevs,
        revs: RotFreq.min(state.revs, maxRevs),
        redline: RotFreq.min(state.redline, maxRevs),
      ),
    );
  }

  void setRevs(RotFreq revs) async {
    emit(state.copyWith(revs: revs));
  }

  void setRedline(RotFreq redline) async {
    emit(state.copyWith(redline: redline));
  }

  void setMileage(Distance mileage) async {
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
