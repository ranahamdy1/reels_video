import 'package:flutter/material.dart';

class LikeIcon extends StatelessWidget {
  Future<int> tempFuture() async {
    return Future.delayed(const Duration(seconds: 1));
  }

  const LikeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: tempFuture(),
        builder: (context, snapShot) =>
            snapShot.connectionState != ConnectionState.done
                ? const Icon(
                    Icons.favorite,
                    size: 110,
                  )
                : const SizedBox(),
      ),
    );
  }
}
