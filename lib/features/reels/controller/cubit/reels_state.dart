abstract class ReelsState {}

class ReelsInitialState extends ReelsState {}

class ReelsLoadingState extends ReelsState {}
class ReelsSuccessState extends ReelsState {}
class ReelsFailedState extends ReelsState {
  final String msg;
  ReelsFailedState({required this.msg});
}