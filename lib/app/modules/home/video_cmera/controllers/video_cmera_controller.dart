import 'dart:async';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../review_video/views/review_video_view.dart';

class VideoCmeraController extends GetxController {
  // Camera controller
  late CameraController cameraController;

  // Recording states
  final isRecording = false.obs;
  final videoPath = "".obs;
  final recordingTime = "00:00".obs;
  final isCameraInitialized = false.obs;
  final hasError = false.obs;
  final errorMessage = "".obs;

  // Timer
  Timer? _recordingTimer;
  int _recordingSeconds = 0;

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }

  /// Initialize camera - Get cameras and setup controller
  Future<void> _initializeCamera() async {
    try {
      // ✅ Get available cameras from device
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw Exception("No cameras available on this device");
      }

      debugPrint("📷 Found ${cameras.length} camera(s)");
      debugPrint("🎥 Using: ${cameras.first.name}");

      // Initialize CameraController with first camera (back camera)
      cameraController = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await cameraController.initialize();
      isCameraInitialized.value = true;
      hasError.value = false;

      update();
      debugPrint("✅ Camera initialized successfully");
    } catch (e) {
      isCameraInitialized.value = false;
      hasError.value = true;
      errorMessage.value = e.toString();
      debugPrint("❌ Camera initialization error: $e");
    }
  }

  /// Start recording
  Future<void> startRecording() async {
    try {
      if (!cameraController.value.isInitialized) {
        Get.snackbar(
          "Error",
          "Camera not initialized",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (cameraController.value.isRecordingVideo) {
        debugPrint("⚠️ Already recording");
        return;
      }

      await cameraController.startVideoRecording();

      isRecording.value = true;
      _recordingSeconds = 0;
      _startTimer();

      debugPrint("🔴 Recording started");
      update();
    } catch (e) {
      debugPrint("❌ Error starting recording: $e");
      Get.snackbar(
        "Recording Error",
        "Failed to start recording",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Stop recording
  Future<void> stopRecording(String type) async {
    try {
      if (!cameraController.value.isRecordingVideo) {
        return;
      }

      final video = await cameraController.stopVideoRecording();

      isRecording.value = false;
      videoPath.value = video.path;
      _stopTimer();

      debugPrint("⏹️ Recording stopped");
      debugPrint("📹 Video path: ${video.path}");
      debugPrint("⏱️ Recording duration: ${_recordingSeconds}s");

      update();

      // Navigate to review screen
      await Get.to(
        ReviewVideoView(
          videoPath: video.path,
          navigatorType:type,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error stopping recording: $e");
      Get.snackbar(
        "Recording Error",
        "Failed to stop recording",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Start recording timer
  void _startTimer() {
    _recordingTimer?.cancel();
    _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _recordingSeconds++;
      _updateTimerDisplay();
    });
  }

  /// Stop recording timer
  void _stopTimer() {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    _recordingSeconds = 0;
    recordingTime.value = "00:00";
  }

  /// Update timer display (MM:SS format)
  void _updateTimerDisplay() {
    final minutes = _recordingSeconds ~/ 60;
    final seconds = _recordingSeconds % 60;
    recordingTime.value =
    "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  /// Check if max recording duration reached (optional)
  bool isMaxDurationReached(int maxSeconds) {
    return _recordingSeconds >= maxSeconds;
  }

  /// Get formatted duration
  String getFormattedDuration() {
    final minutes = _recordingSeconds ~/ 60;
    final seconds = _recordingSeconds % 60;
    return "${minutes}m ${seconds}s";
  }

  @override
  void onClose() {
    _stopTimer();
    if (isCameraInitialized.value) {
      cameraController.dispose();
    }
    debugPrint("🛑 VideoCameraController closed");
    super.onClose();
  }
}