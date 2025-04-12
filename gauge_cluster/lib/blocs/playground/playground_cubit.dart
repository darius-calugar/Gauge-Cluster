import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'playground_state.dart';

class PlaygroundCubit extends Cubit<PlaygroundState> {
  PlaygroundCubit({required this.exampleCount, int example = 1})
    : super(PlaygroundState(example: example, areControlsExpanded: false));

  final int exampleCount;

  void setExample(int example) async {
    emit(
      PlaygroundState(
        example: example % exampleCount,
        areControlsExpanded: state.areControlsExpanded,
      ),
    );
  }

  void setPreviousExample() async {
    setExample(state.example - 1);
  }

  void setNextExample() async {
    setExample(state.example + 1);
  }

  void toggleControls() async {
    emit(
      PlaygroundState(
        example: state.example,
        areControlsExpanded: !state.areControlsExpanded,
      ),
    );
  }
}
