import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'playground_state.dart';

class PlaygroundCubit extends Cubit<PlaygroundState> {
  PlaygroundCubit({required this.exampleCount})
    : super(PlaygroundState(example: 1));

  final int exampleCount;

  void setExample(int example) async {
    emit(PlaygroundState(example: (example - 1) % exampleCount + 1));
  }

  void setPreviousExample() async {
    setExample(state.example - 1);
  }

  void setNextExample() async {
    setExample(state.example + 1);
  }
}
