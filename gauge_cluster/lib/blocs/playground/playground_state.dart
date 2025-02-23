part of 'playground_cubit.dart';

final class PlaygroundState extends Equatable {
  const PlaygroundState({
    required this.example,
    required this.areControlsExpanded,
  });

  final int example;
  final bool areControlsExpanded;

  @override
  List<Object?> get props => [example, areControlsExpanded];
}
