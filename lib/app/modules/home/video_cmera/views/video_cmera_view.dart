import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'dart:io';
import '../../../../../main.dart';
import '../../../../core/const/app_colors.dart';
import '../../review_video/views/review_video_view.dart';
import '../controllers/video_cmera_controller.dart';
import 'package:video_player/video_player.dart';

class VideoCmeraView extends StatefulWidget {
  const VideoCmeraView({super.key});

  @override
  State<VideoCmeraView> createState() => _VideoCmeraViewState();
}

class _VideoCmeraViewState extends State<VideoCmeraView> {
  late CameraController controller;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: true,
    );
    controller.initialize().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    await controller.startVideoRecording();
    setState(() => isRecording = true);
  }

  Future<void> stopRecording() async {
    final video = await controller.stopVideoRecording();
    setState(() => isRecording = false);
    print('video path ${video.path}');
    Get.to(ReviewVideoView(videoPath: video.path,));
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25.h),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppBackButton(),
          ),

          SizedBox(height: 20.h),

          /// CAMERA PREVIEW
          Expanded(
            child: Container(
                width: double.infinity,
                child: CameraPreview(controller)),
          ),

          /// RECORD BUTTON
          Container(
            height: 123.h,
            width: double.infinity,
            color: AppColors.primaryColor,
            child: InkWell(
              onTap: () {
                if (isRecording) {
                  stopRecording();
                } else {
                  startRecording();
                }
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  height: 75.h,
                  width: 75.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.textSecoundaryColor,
                      width: 2,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isRecording
                          ? AppColors.errorColor
                          : AppColors.secoundaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

