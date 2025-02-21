part of 'playground_cubit.dart';

final class PlaygroundState extends Equatable {
  const PlaygroundState({required this.example});

  final int example;

  @override
  List<Object?> get props => [example];
}
