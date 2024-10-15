import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reels_video/features/reels/controller/cubit/content/content_cubit.dart';
import 'package:reels_video/features/reels/controller/cubit/content/content_state.dart';
import 'widgets/like_icon.dart';

class ContentScreen extends StatelessWidget {
  final String src;
  const ContentScreen({super.key, required this.src});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContentCubit(src),
      child: BlocBuilder<ContentCubit, ContentState>(
        builder: (context, state) {
          final cubit = context.read<ContentCubit>();

          if (state is ContentLoadingState) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Loading....."),
                ],
              ),
            );
          }

          if (state is ContentFailedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.msg),
                  ElevatedButton(
                    onPressed: () {
                      cubit.initializePlayer(src);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ContentSuccessState && cubit.chewieController != null) {
            return Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                  onDoubleTap: () {
                    cubit.toggleLike();
                  },
                  child: Chewie(controller: cubit.chewieController!),
                ),
                if (state.isLiked)
                  const Center(
                    child: LikeIcon(),
                  ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
