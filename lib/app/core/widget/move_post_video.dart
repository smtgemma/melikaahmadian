import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class SafeMoveVideo extends StatefulWidget {
  final String? videoUrl;
  const SafeMoveVideo({super.key, this.videoUrl});

  @override
  State<SafeMoveVideo> createState() => _SafeMoveVideoState();
}

class _SafeMoveVideoState extends State<SafeMoveVideo> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isError = false;
  bool _isInitialized = false;
  bool _userWantsToPlay = false; // Add this flag

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    );

    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false, //video inital vabe off takbe
        fullScreenByDefault: true,
        looping: false,
        allowFullScreen: false,
        showControls: true, //video inital vabe off takbe
        aspectRatio: _videoPlayerController.value.aspectRatio,
        allowPlaybackSpeedChanging: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp, // fullscreen থেকে বের হলে আবার portrait
        ],
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft, // fullscreen গেলে landscape হবে
        ],
      );
      _videoPlayerController.pause();
      setState(() {});
    });
  }

  // Future<void> _initializeVideo() async {
  //   if (widget.videoUrl == null || widget.videoUrl!.isEmpty) {
  //     setState(() => _isError = true);
  //     return;
  //   }
  //
  //   try {
  //     _controller = VideoPlayerController.network(widget.videoUrl!);
  //     await _controller!.initialize();
  //
  //     if (!mounted) return;
  //
  //     _chewieController = ChewieController(
  //       videoPlayerController: _controller!,
  //       autoPlay: true, // Auto-play once initialized
  //       looping: false,
  //       showControls: true,
  //       allowFullScreen: false,
  //     );
  //
  //     setState(() => _isInitialized = true);
  //   } catch (e) {
  //     debugPrint("⚠️ Video init error: $e");
  //     if (mounted) setState(() => _isError = true);
  //   }
  // }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return Container(
        height: 120,
        color: Colors.black12,
        alignment: Alignment.center,
        child: const Text("Video not available"),
      );
    }

    if (!_userWantsToPlay) {
      // Show a thumbnail/preview with play button
      return GestureDetector(
        onTap: () {
          setState(() => _userWantsToPlay = true);
          //  _initializeVideo();
        },
        child: Container(
          height: 120,
          color: Colors.black12,
          alignment: Alignment.center,
          child: const Icon(
            Icons.play_circle_outline,
            size: 48,
            color: Colors.white,
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: 120,
      child: Chewie(controller: _chewieController!),
    );
  }
}