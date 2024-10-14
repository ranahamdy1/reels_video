import 'package:chewie/chewie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  ContentCubit(String src) : super(ContentInitialState()) {
    initializePlayer(src);
  }

  Future<void> initializePlayer(String src) async {
    try {
      emit(ContentLoadingState());

      videoPlayerController = VideoPlayerController.network(src);
      await videoPlayerController!.initialize();

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        showControls: false,
        looping: true,
      );

      emit(ContentSuccessState());
    } catch (e) {
      emit(ContentFailedState(msg: 'Failed to load video: $e'));
    }
  }

  void toggleLike() {
    if (state is ContentSuccessState) {
      emit((state as ContentSuccessState)
          .copyWith(isLiked: !(state as ContentSuccessState).isLiked));
    }
  }

  @override
  Future<void> close() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    return super.close();
  }
}
