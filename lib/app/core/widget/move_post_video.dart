// import 'package:chewie/chewie.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter/material.dart';
//
// class SafeMoveVideo extends StatefulWidget {
//   final String? videoUrl;
//   const SafeMoveVideo({super.key, this.videoUrl});
//
//   @override
//   State<SafeMoveVideo> createState() => _SafeMoveVideoState();
// }
//
// class _SafeMoveVideoState extends State<SafeMoveVideo> {
//   late VideoPlayerController _videoPlayerController;
//   ChewieController? _chewieController;
//   bool _isError = false;
//   bool _isInitialized = false;
//   bool _userWantsToPlay = false;
//
//   get _initializeVideoPlayerFuture => null;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _videoPlayerController = VideoPlayerController.networkUrl(
//       Uri.parse(
//         widget.videoUrl ??
//             'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//       ),
//     );
//   }
//
//   Future<void> _initializeAndPlay() async {
//     try {
//       await _videoPlayerController.initialize();
//
//       _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController,
//         autoPlay: true, // ✅ play automatically after tap
//         looping: true,
//         allowFullScreen: true,
//         showControls: true,
//         aspectRatio: _videoPlayerController.value.aspectRatio,
//         deviceOrientationsAfterFullScreen: [
//           DeviceOrientation.portraitUp,
//         ],
//         deviceOrientationsOnEnterFullScreen: [
//           DeviceOrientation.landscapeLeft,
//           DeviceOrientation.landscapeRight,
//         ],
//       );
//
//       if (!mounted) return;
//
//       setState(() {
//         _isInitialized = true;
//       });
//     } catch (e) {
//       debugPrint("Video init error: $e");
//       if (mounted) setState(() => _isError = true);
//     }
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   // Widget build(BuildContext context) {
//   //   if(_initializeVideoPlayerFuture == null) {
//   //     return SizedBox(height: 200.h, width: double.infinity,child:   SizedBox(
//   //       width: 40,
//   //       height: 40,
//   //       child: Center(child: CircularProgressIndicator()),
//   //     ) );
//   //   }
//   //   return SizedBox(
//   //     height: 200.h,
//   //     width: double.infinity,
//   //     child: FutureBuilder(
//   //       future: _initializeVideoPlayerFuture,
//   //       builder: (context, snapshot) {
//   //         if (snapshot.connectionState == ConnectionState.done &&
//   //             _chewieController != null) {
//   //           return Chewie(controller: _chewieController!);
//   //         } else if (snapshot.hasError) {
//   //           return Text('Error: ${snapshot.error}');
//   //         } else {
//   //           return SizedBox(
//   //             width: 40,
//   //             height: 40,
//   //             child: Center(child: CircularProgressIndicator()),
//   //           );
//   //         }
//   //       },
//   //     ),
//   //   );
//   // }
//
//   Widget build(BuildContext context) {
//     if (_isError) {
//       return Container(
//         height: 120,
//         color: Colors.black12,
//         alignment: Alignment.center,
//         child: const Text("Video not available"),
//       );
//     }
//
//     /// ▶️ Preview with play icon
//     if (!_userWantsToPlay) {
//       return GestureDetector(
//         onTap: () async {
//           setState(() => _userWantsToPlay = true);
//           await _initializeAndPlay(); // ✅ load & play
//         },
//         child: Container(
//           height: 120,
//           color: Colors.black12,
//           alignment: Alignment.center,
//           child: const Icon(
//             Icons.play_circle_outline,
//             size: 48,
//             color: Colors.white,
//           ),
//         ),
//       );
//     }
//
//     /// ⏳ Loading
//     if (!_isInitialized) {
//       return const SizedBox(
//         height: 120,
//         child: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     /// 🎬 Playing
//     return SizedBox(
//       height: 120,
//       child: Chewie(controller: _chewieController!),
//     );
//   }
// }
