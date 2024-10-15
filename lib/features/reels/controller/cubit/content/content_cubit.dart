import 'package:chewie/chewie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reels_video/core/video_cache_manager.dart';
import 'package:video_player/video_player.dart';
import 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  ContentCubit(String src) : super(ContentInitialState()) {
    initializePlayer(src);
  }
  // Future<void> cacheVideos(List<String> urls) async {
  //   // Cache videos one at a time for better memory management
  //   for (String url in urls) {
  //     await CustomCacheManager.instance.getSingleFile(url);
  //   }
  // }

  Future<void> cacheVideos(List<String> urls) async {
    int batchSize = 2;
    for (int i = 0; i < urls.length; i += batchSize) {
      final batch = urls.sublist(i, i + batchSize > urls.length ? urls.length : i + batchSize);
      for (String url in batch) {
        await CustomCacheManager.instance.getSingleFile(url);
      }
      emit(ContentLoadingState());
    }
  }


  Future<void> initializePlayer(String src) async {
    try {
      emit(ContentLoadingState());
      final file = await CustomCacheManager.instance.getSingleFile(src);
      videoPlayerController = VideoPlayerController.file(file);
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
