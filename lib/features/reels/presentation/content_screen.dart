import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:reels_video/features/reels/presentation/like_icon.dart';
import 'package:video_player/video_player.dart';

class ContentScreen extends StatefulWidget {
  final String src;
   const ContentScreen({super.key, required this.src});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future initializePlayer() async{
    _videoPlayerController = VideoPlayerController.network(widget.src);
    await Future.wait([_videoPlayerController!.initialize()]);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      showControls: false,
      looping: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized ?
        GestureDetector(
          onDoubleTap: (){
            setState(() {
              _liked = !_liked;
            });
          },
            child: Chewie(controller: _chewieController!)):
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text("Loading.....")
          ],
        ),
        if(_liked)
          const Center(
            child: LikeIcon(),
          ),
      ],
    );
  }
}
