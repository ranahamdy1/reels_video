import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reels_video/core/dio_helper.dart';
import 'package:reels_video/core/end_points.dart';
import 'package:reels_video/features/reels/controller/cubit/reels/reels_state.dart';
import 'package:reels_video/features/reels/models/reels_model.dart';

class ReelsCubit extends Cubit<ReelsState> {
  ReelsCubit() : super(ReelsInitialState());

  static ReelsCubit get(context) => BlocProvider.of(context);
  ReelsModel? reelsModel;

  void getReels() {
    {
      emit(ReelsLoadingState());
      DioHelper.getData(
        url: Endpoints.getReels,
      ).then((value) {
        reelsModel = ReelsModel.fromJson(value.data);
        emit(ReelsSuccessState());
      }).catchError((onError) {
        emit(ReelsFailedState(msg: onError.toString()));
        print(onError);
      });
    }
  }
}
