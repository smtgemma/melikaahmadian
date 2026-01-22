import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import '../controllers/video_cmera_controller.dart';

class VideoCmeraView extends GetView<VideoCmeraController> {
  final bool isBackButton;
  final String? navigatorType;

  const VideoCmeraView({
    super.key,
    this.isBackButton = false,
    this.navigatorType,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCmeraController>(
      init: VideoCmeraController(),
      builder: (_) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            if (!isBackButton)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: AppBackButton(),
              ),
            SizedBox(height: 20.h),

            /// CAMERA PREVIEW WITH TIMER
            Expanded(child: _buildCameraPreview(context)),

            /// RECORD BUTTON SECTION
            _buildRecordingControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Camera preview - ✅ FIXED: Use controller directly, not .value
        Obx(() {
          if (!controller.isCameraInitialized.value) {
            return Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.secoundaryColor,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Initializing Camera...',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            );
          }
          // ✅ FIXED: Pass controller directly, not controller.value
          return CameraPreview(controller.cameraController);
        }),

        // Top gradient overlay with better styling
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 120.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Recording indicator with timer - Enhanced design
        Positioned(
          top: 50.h,
          left: 0,
          right: 0,
          child: Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Recording indicator - Animated
                  if (controller.isRecording.value)
                    ScaleTransition(
                      scale: AlwaysStoppedAnimation(1.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(24.w),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.6),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Blinking dot
                            _buildBlinkingDot(),
                            SizedBox(width: 8.w),
                            Text(
                              'RECORDING',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Timer display - Beautiful design
                  if (controller.isRecording.value)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12.w),
                        border: Border.all(
                          color: Colors.red.withOpacity(0.5),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Obx(
                        () => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.red,
                              size: 16.sp,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              controller.recordingTime.value,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                fontFamily: 'monospace',
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        // Bottom gradient overlay
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 150.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Blinking dot indicator
  Widget _buildBlinkingDot() {
    return AnimatedOpacity(
      opacity: (DateTime.now().millisecond ~/ 500) % 2 == 0 ? 1.0 : 0.4,
      duration: Duration(milliseconds: 500),
      child: Container(
        width: 10.w,
        height: 10.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordingControls() {
    return Obx(
      () => AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 150.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.w),
            topRight: Radius.circular(24.w),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Status text with animation
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 300),
              child: Text(
                controller.isRecording.value
                    ? '⏹ Tap to Stop Recording'
                    : '⏸ Tap to Start Recording',
                style: TextStyle(
                  color: controller.isRecording.value
                      ? Colors.red[400]
                      : Colors.grey[400],
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Record button with advanced animation
            GestureDetector(
              onTap: () {
                if (controller.isRecording.value) {
                  controller.stopRecording(navigatorType ?? '');
                } else {
                  controller.startRecording();
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(6.w),
                height: 75.h,
                width: 75.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.textSecoundaryColor,
                    width: controller.isRecording.value ? 4 : 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: controller.isRecording.value
                          ? Colors.red.withOpacity(0.6)
                          : AppColors.secoundaryColor.withOpacity(0.3),
                      blurRadius: controller.isRecording.value ? 20 : 10,
                      spreadRadius: controller.isRecording.value ? 4 : 0,
                    ),
                  ],
                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.isRecording.value
                        ? AppColors.errorColor
                        : AppColors.secoundaryColor,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // Additional info
            if (controller.isRecording.value)
              Text(
                '📱 Keep device steady',
                style: TextStyle(
                  color: Colors.orange[300],
                  fontSize: 11.sp,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
              )
            else
              Text(
                'Hold for high quality video',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 11.sp,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
