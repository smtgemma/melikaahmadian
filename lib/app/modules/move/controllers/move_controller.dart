import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class MoveController extends GetxController {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  late Future<void> initializeVideoPlayerFuture;

  RxList moveitem = [
    "All Moves",
    "Ongoing",
    "Posted",
    "Completed",
    "Cancelled"
  ].obs;

  RxString selectedValue = "".obs;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    );

    initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false, //video inital vabe off takbe
        fullScreenByDefault: true,
        looping: false,
        allowFullScreen: false,
        showControls: false, //video inital vabe off takbe
        aspectRatio: videoPlayerController.value.aspectRatio,
        allowPlaybackSpeedChanging: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp, // fullscreen থেকে বের হলে আবার portrait
        ],
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft, // fullscreen গেলে landscape হবে
        ],
      );
      videoPlayerController.pause();
     update();
    });
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}

