import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../modules/move/controllers/move_controller.dart';

class MovessVideo extends StatefulWidget {
  String? videoPath;
  bool? isasset;
  MovessVideo({super.key,  this.videoPath, this.isasset});

  @override
  State<MovessVideo> createState() => _MovessVideoState();
}

class _MovessVideoState extends State<MovessVideo> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    print('video is ${widget.videoPath}');
    // if (widget.videoPath == null && widget.isasset == null) {
    //   return;
    // }
    if (widget.isasset == true) {
      // Asset video
      _videoPlayerController = VideoPlayerController.file(
        File(widget.videoPath ?? ''),
      );
    } else {
      // File video
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse( widget.videoPath ??'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',),
      );
    }

    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((
        _,
        ) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        showControls: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if(_initializeVideoPlayerFuture == null) {
      return SizedBox(height: 200.h, width: double.infinity,child:   SizedBox(
        width: 40,
        height: 40,
        child: Center(child: CircularProgressIndicator()),
      ) );
    }
    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              _chewieController != null) {
            return Chewie(controller: _chewieController!);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return SizedBox(
              width: 40,
              height: 40,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
