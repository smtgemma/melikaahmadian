// import 'dart:io';
//
// import 'package:chewie/chewie.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../modules/move/controllers/move_controller.dart';
//
// class MoveVideo extends StatefulWidget {
//   String? videoPath;
//   bool? isasset;
//   MoveVideo({super.key,  this.videoPath, this.isasset});
//
//   @override
//   State<MoveVideo> createState() => _MoveVideoState();
// }
//
// class _MoveVideoState extends State<MoveVideo> {
//   late VideoPlayerController _videoPlayerController;
//   ChewieController? _chewieController;
//    Future<void>? _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     print('video is ${widget.videoPath}');
//     // if (widget.videoPath == null && widget.isasset == null) {
//     //   return;
//     // }
//     if (widget.isasset == true) {
//       // Asset video
//       _videoPlayerController = VideoPlayerController.file(
//         File(widget.videoPath ?? ''),
//       );
//     } else {
//       // File video
//       _videoPlayerController = VideoPlayerController.networkUrl(
//         Uri.parse( widget.videoPath ??'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',),
//       );
//     }
//
//     _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((
//       _,
//     ) {
//       _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController,
//         autoPlay: true,
//         looping: false,
//         aspectRatio: _videoPlayerController.value.aspectRatio,
//       );
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }
//
//   Widget build(BuildContext context) {
//     if(_initializeVideoPlayerFuture == null) {
//       return SizedBox(height: 200.h, width: double.infinity,child:   SizedBox(
//         width: 40,
//         height: 40,
//         child: Center(child: CircularProgressIndicator()),
//       ) );
//     }
//     return SizedBox(
//       height: 200.h,
//       width: double.infinity,
//       child: FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done &&
//               _chewieController != null) {
//             return Chewie(controller: _chewieController!);
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return SizedBox(
//               width: 40,
//               height: 40,
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class MoveVideo extends StatefulWidget {
  final String? videoPath;
  final bool isAsset;

  const MoveVideo({
    super.key,
    this.videoPath,
    this.isAsset = false,
  });

  @override
  State<MoveVideo> createState() => _MoveVideoState();
}

class _MoveVideoState extends State<MoveVideo> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      if (widget.videoPath == null || widget.videoPath!.isEmpty) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Video path is empty';
        });
        return;
      }

      // Initialize video player controller
      if (widget.isAsset) {
        _videoPlayerController = VideoPlayerController.file(
          File(widget.videoPath!),
        );
      } else {
        _videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(widget.videoPath!),
        );
      }

      // Add listener for errors
      _videoPlayerController.addListener(_handleVideoError);

      // Initialize the controller
      await _videoPlayerController.initialize();

      // Create Chewie controller
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        progressIndicatorDelay: Duration(milliseconds: 200),
        showControlsOnInitialize: true,
      );

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _hasError = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Failed to load video: ${e.toString()}';
        });
      }
    }
  }

  void _handleVideoError() {
    if (_videoPlayerController.value.hasError && mounted) {
      setState(() {
        _hasError = true;
        _errorMessage = _videoPlayerController.value.errorDescription ??
            'Unknown video error occurred';
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(_handleVideoError);
    _chewieController?.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.red),
              SizedBox(height: 12.h),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      );
    }

    if (!_isInitialized || _chewieController == null) {
      return Container(
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.w),
        color: Colors.black,
      ),
      child: Chewie(controller: _chewieController!),
    );
  }
}