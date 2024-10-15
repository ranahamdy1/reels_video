import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reels_video/core/dio_helper.dart';
import 'package:reels_video/core/end_points.dart';
import 'package:reels_video/core/video_cache_manager.dart';
import 'package:reels_video/features/reels/controller/cubit/reels/reels_state.dart';
import 'package:reels_video/features/reels/models/reels_model.dart';

class ReelsCubit extends Cubit<ReelsState> {
  ReelsCubit() : super(ReelsInitialState());

  static ReelsCubit get(context) => BlocProvider.of(context);
  ReelsModel? reelsModel;
  final customCacheManager = CustomCacheManager.instance;

  void getReels() {
    emit(ReelsLoadingState());
    DioHelper.getData(
      url: Endpoints.getReels,
    ).then((value) async {
      reelsModel = ReelsModel.fromJson(value.data);

      if (reelsModel?.data != null) {
        const int batchSize = 3;
        for (int i = 0; i < reelsModel!.data!.length; i += batchSize) {
          final batch = reelsModel!.data!.sublist(
              i,
              i + batchSize > reelsModel!.data!.length
                  ? reelsModel!.data!.length
                  : i + batchSize);

          for (var reel in batch) {
            await customCacheManager.downloadFile(reel!.video!);
          }
          print('Batch $i cached successfully');
        }
      }

      emit(ReelsSuccessState());
    }).catchError((onError) {
      emit(ReelsFailedState(msg: onError.toString()));
      print(onError);
    });
  }
}
