import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import '../../video_cmera/controllers/video_cmera_controller.dart';
import '../controllers/add_details_controller.dart';

class AddDetailsRepository {
  static final videoCameraController = Get.find<VideoCmeraController>();
  static final addDetailsController = Get.find<AddDetailsController>();

  static Future<void> aiGenaredVideo() async {
    try {
      final videoPath = videoCameraController.videoPath.value;

      // Validate video path
      if (videoPath.isEmpty) {
        throw Exception("Video path is empty");
      }

      debugPrint("Uploading video from: $videoPath");

      // Create form data with video file
      final formData = FormData.fromMap({
        "video_file": await MultipartFile.fromFile(videoPath),
        "home_type": addDetailsController.selectedDateText.value,
        "room_count": 2,
      });

      // Log form data fields
      for (var field in formData.fields) {
        debugPrint("FormData field: ${field.key} = ${field.value}");
      }

      // Make API request with longer timeout for large files
      addDetailsController.isLoading.value = true;

      final response = await DioClient().post(
        AppUrls.analyzVideo,
        data: formData,
        duration: Duration(minutes: 5),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        addDetailsController.isLoading.value = false;
        final message = response.data["message"] ?? "Video uploaded successfully";
        Get.snackbar(
          "Success",
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        debugPrint("✅ Video uploaded successfully");
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } on DioException catch (e) {
      addDetailsController.isLoading.value = false;

      String errorMessage = "Failed to upload video";

      if (e.response != null) {
        errorMessage = e.response?.data["message"] ??
            "Server error: ${e.response?.statusCode}";
        debugPrint("❌ Error response: ${e.response?.data}");
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = "Connection timeout. Please check your internet";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = "Upload timeout. Please try again";
      } else {
        errorMessage = "Error: ${e.message}";
      }

      debugPrint("Error: $errorMessage");

      Get.snackbar(
        "Upload Failed",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      addDetailsController.isLoading.value = false;
      final errorMessage = e.toString();

      debugPrint("❌ Unexpected error: $errorMessage");

      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }

  // Helper method to validate video file
  static Future<bool> validateVideoFile(String videoPath) async {
    try {
      final file = File(videoPath);
      if (!await file.exists()) {
        debugPrint("❌ Video file does not exist");
        return false;
      }

      final bytes = await file.length();
      final mb = bytes / (1024 * 1024);
      debugPrint("🎥 Video size: ${mb.toStringAsFixed(2)} MB");

      // Check if video is too large (e.g., > 100 MB)
      if (mb > 100) {
        Get.snackbar(
          "Video Too Large",
          "Maximum file size is 100 MB",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      return true;
    } catch (e) {
      debugPrint("❌ Error validating video: $e");
      return false;
    }
  }
}

