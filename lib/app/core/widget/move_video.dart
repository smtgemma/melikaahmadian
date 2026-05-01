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
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:video_player/video_player.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'shimmer_loader.dart';

// class MoveVideo extends StatefulWidget {
//   final String? videoPath;
//   final bool isAsset;
//
//   const MoveVideo({
//     super.key,
//     this.videoPath,
//     this.isAsset = false,
//   });
//
//   @override
//   State<MoveVideo> createState() => _MoveVideoState();
// }
//
// class _MoveVideoState extends State<MoveVideo> {
//   late VideoPlayerController _videoPlayerController;
//   ChewieController? _chewieController;
//   bool _isInitialized = false;
//   bool _hasError = false;
//   String _errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoPlayer();
//   }
//
//   Future<void> _initializeVideoPlayer() async {
//     try {
//       if (widget.videoPath == null || widget.videoPath!.isEmpty) {
//         setState(() {
//           _hasError = true;
//           _errorMessage = 'Video path is empty';
//         });
//         return;
//       }
//
//       // Initialize video player controller
//       if (widget.isAsset) {
//         _videoPlayerController = VideoPlayerController.file(
//           File(widget.videoPath!),
//         );
//       } else {
//         _videoPlayerController = VideoPlayerController.networkUrl(
//           Uri.parse(widget.videoPath!),
//         );
//       }
//
//       // Add listener for errors
//       _videoPlayerController.addListener(_handleVideoError);
//
//       // Initialize the controller
//       await _videoPlayerController.initialize();
//
//       // Create Chewie controller
//       _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController,
//         autoPlay: true,
//         looping: false,
//         progressIndicatorDelay: Duration(milliseconds: 200),
//         showControlsOnInitialize: true,
//       );
//
//       if (mounted) {
//         setState(() {
//           _isInitialized = true;
//           _hasError = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _hasError = true;
//           _errorMessage = 'Failed to load video: ${e.toString()}';
//         });
//       }
//     }
//   }
//
//   void _handleVideoError() {
//     if (_videoPlayerController.value.hasError && mounted) {
//       setState(() {
//         _hasError = true;
//         _errorMessage = _videoPlayerController.value.errorDescription ??
//             'Unknown video error occurred';
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.removeListener(_handleVideoError);
//     _chewieController?.dispose();
//     _videoPlayerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_hasError) {
//       return Container(
//         height: 200.h,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: BorderRadius.circular(12.w),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.error_outline, size: 48, color: Colors.red),
//               SizedBox(height: 12.h),
//               Expanded(
//                 child: Text(
//                   _errorMessage,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     if (!_isInitialized || _chewieController == null) {
//       return Container(
//         height: 200.h,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: BorderRadius.circular(12.w),
//         ),
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     return Container(
//       height: 200.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12.w),
//         color: Colors.black,
//       ),
//       child: Chewie(controller: _chewieController!),
//     );
//   }
// }

class MoveVideo extends StatefulWidget {
  final String? videoPath;
  final bool isAsset;

  const MoveVideo({super.key, this.videoPath, this.isAsset = false});

  @override
  State<MoveVideo> createState() => _MoveVideoState();
}

class _MoveVideoState extends State<MoveVideo> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _userWantsToPlay = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Lazy loading: Don't initialize until user wants to play
  }

  Future<void> _initializeVideoPlayer() async {
    if (_isInitialized) return;

    try {
      if (widget.videoPath == null || widget.videoPath!.isEmpty) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Video path is empty';
        });
        return;
      }

      debugPrint('🎥 Initializing Video: ${widget.videoPath}');

      // Initialize video player controller
      if (widget.isAsset) {
        final file = File(widget.videoPath!);
        if (!await file.exists()) {
          throw Exception('Video file not found');
        }
        _videoPlayerController = VideoPlayerController.file(file);
      } else {
        debugPrint("⏳ Caching network video: ${widget.videoPath}");
        final file = await DefaultCacheManager().getSingleFile(
          widget.videoPath!,
        );
        _videoPlayerController = VideoPlayerController.file(file);
      }

      // Add listener for errors
      _videoPlayerController?.addListener(_handleVideoError);

      // Initialize the controller with timeout
      await _videoPlayerController?.initialize().timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw Exception('Video initialization timeout');
        },
      );

      // Create Chewie controller
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        placeholder: Container(color: Colors.black),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 42, color: Colors.red),
                const SizedBox(height: 8),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ),
          );
        },
      );

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _hasError = false;
        });
      }
    } catch (e, stackTrace) {
      debugPrint('🎥 Error initializing video: $e');
      debugPrint('🎥 StackTrace: $stackTrace');

      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Failed to load video: ${e.toString()}';
        });
      }
    }
  }

  void _handleVideoError() {
    if (_videoPlayerController != null &&
        _videoPlayerController!.value.hasError &&
        mounted) {
      debugPrint(
        '🎥 Video Player Error: ${_videoPlayerController!.value.errorDescription}',
      );
      setState(() {
        _hasError = true;
        _errorMessage =
            _videoPlayerController!.value.errorDescription ??
            'Unknown video error occurred';
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.removeListener(_handleVideoError);
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return _buildErrorWidget();
    }

    if (!_userWantsToPlay) {
      return _buildPreviewWidget();
    }

    if (!_isInitialized || _chewieController == null) {
      return Container(
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Center(
          child: CircularProgressIndicator(color: AppColors.secoundaryColor),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.w),
      child: Container(
        height: 200.h,
        width: double.infinity,
        color: Colors.black,
        child: Chewie(controller: _chewieController!),
      ),
    );
  }

  Widget _buildPreviewWidget() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _userWantsToPlay = true;
        });
        _initializeVideoPlayer();
      },
      child: Container(
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Thumbnail placeholder
            Icon(Icons.videocam_outlined, size: 50.w, color: Colors.grey[400]),

            // Play Button
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.secoundaryColor.withOpacity(0.8),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 40.w,
              ),
            ),

            // "Tap to play" text
            Positioned(
              bottom: 20.h,
              child: Text(
                "Tap to play video",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.videocam_off_outlined,
                  size: 40,
                  color: Colors.red[400],
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Video Unavailable',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 11.sp),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 16.h),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _hasError = false;
                    _isInitialized = false;
                    _userWantsToPlay = true;
                  });
                  _initializeVideoPlayer();
                },
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secoundaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
