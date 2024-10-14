import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe/flutter_swipe.dart';
import 'package:reels_video/features/reels/controller/cubit/reels_cubit.dart';
import 'package:reels_video/features/reels/controller/cubit/reels_state.dart';
import 'content_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReelsCubit()..getReels(),
      child: BlocConsumer<ReelsCubit, ReelsState>(
        listener: (context, state) {
          if (state is ReelsInitialState) {
            print("CounterInitialState");
          } else if (state is ReelsSuccessState) {
            print("ReelsSuccessState");
          } else if (state is ReelsFailedState) {
            print("ReelsFailedState: ${state.msg}");
          }
        },
        builder: (context, state) {
          if (state is ReelsSuccessState) {
            final cubit = ReelsCubit.get(context).reelsModel;
            if (cubit != null && cubit.data != null) {
              return Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  children: [
                    Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return ContentScreen(src: "${cubit.data![index].video}");
                      },
                      itemCount: cubit.data!.length,
                      scrollDirection: Axis.vertical,
                    )
                  ],
                ),
              );
            }
          } else if (state is ReelsFailedState) {
            return Center(child: Text("Failed to load data: ${state.msg}"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
