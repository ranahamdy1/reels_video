abstract class ContentState {}

class ContentInitialState extends ContentState {}

class ContentLoadingState extends ContentState {}

class ContentSuccessState extends ContentState {
  final bool isLiked;
  ContentSuccessState({this.isLiked = false});
  ContentSuccessState copyWith({bool? isLiked}) {
    return ContentSuccessState(isLiked: isLiked ?? this.isLiked);
  }
}

class ContentFailedState extends ContentState {
  final String msg;
  ContentFailedState({required this.msg});
}
