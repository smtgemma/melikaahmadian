import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../modules/move/controllers/move_controller.dart';
class MoveVideo extends StatefulWidget {
  String? videoPath ;
  bool? isasset ;
   MoveVideo({super.key,this.videoPath,this.isasset});

  @override
  State<MoveVideo> createState() => _MoveVideoState();
}

class _MoveVideoState extends State<MoveVideo> {
  @override
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {

    super.initState();
    if(widget.isasset == true){
      debugPrint("debugPrint : ${widget.videoPath}");
      _videoPlayerController = VideoPlayerController.file(
        File(widget.videoPath.toString()),
      );
    }
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    );

    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        fullScreenByDefault: false,
        looping: false,
        allowFullScreen: true,
        showControls: true,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        allowPlaybackSpeedChanging: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
        ],
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ],
      );
      _videoPlayerController.pause();
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
    return Container(
      height: 200.h,
      width: double.infinity,
      child:  FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              _chewieController != null) {
            return Chewie(controller: _chewieController!);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return  SizedBox(
                width: 40,
                height: 40,
                child: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
