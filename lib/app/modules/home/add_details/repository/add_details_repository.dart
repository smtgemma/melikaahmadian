import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:logger/logger.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import '../../video_cmera/controllers/video_cmera_controller.dart';
import '../controllers/add_details_controller.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/analayze_ai_video.dart';

class AddDetailsRepository {
  static final videoCameraController = Get.find<VideoCmeraController>();
  static final addDetailsController = Get.find<AddDetailsController>();

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

  static Future<AnalayzeAiVideo> analyzeVideoApi({
    required File videoFile,
    required String homeType,
    required int roomCount,
  }) async {
    try {
      final uri = Uri.parse("http://72.60.126.182:3033/api/v1/analyze-video");

      debugPrint("────────────────────────────────────");
      debugPrint("➡️ API CALL: Analyze Video");
      debugPrint("🔗 URL: $uri");
      debugPrint("📄 Home Type: $homeType");
      debugPrint("🏠 Room Count: $roomCount");
      debugPrint("🎥 Video Path: ${videoFile.path}");
      debugPrint("📦 Video Exists: ${videoFile.existsSync()}");
      debugPrint("📦 Video Size: ${videoFile.lengthSync()} bytes");

      final request = http.MultipartRequest("POST", uri);

      // ✅ Text fields
      request.fields["home_type"] = homeType;
      request.fields["room_count"] = roomCount.toString();

      debugPrint("📝 Request Fields: ${request.fields}");

      // ✅ File field
      final multipartFile = await http.MultipartFile.fromPath(
        "video_file",
        videoFile.path,
      );
      request.files.add(multipartFile);

      debugPrint("📎 File Field Name: ${multipartFile.field}");
      debugPrint("📎 File Name: ${multipartFile.filename}");
      debugPrint("📎 File Length: ${multipartFile.length}");

      // ✅ Send request
      debugPrint("🚀 Sending request...");
      final streamedResponse = await request.send();

      debugPrint("📡 Response Status Code: ${streamedResponse.statusCode}");
      debugPrint("📡 Response Headers: ${streamedResponse.headers}");

      // ✅ Convert stream to normal response
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint("📥 Raw Response Body:");
      debugPrint(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("✅ Video analysis successful");

        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return AnalayzeAiVideo.fromJson(jsonData);
      } else {
        debugPrint("❌ Video analysis failed");
        debugPrint("❌ Status Code: ${response.statusCode}");
        debugPrint("❌ Response Body: ${response.body}");
        throw Exception("Video analyze failed");
      }
    } catch (e, stackTrace) {
      debugPrint("🔥 Exception occurred while analyzing video");
      debugPrint("❌ Error: $e");
      debugPrint("📍 StackTrace: $stackTrace");
      rethrow;
    } finally {
      debugPrint("────────────────────────────────────");
    }
  }
}
