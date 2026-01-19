import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

import '../../../../../core/const/app_urls.dart';
import '../../../../../core/network/dio_client.dart';
import '../controllers/profile_profile_edit_controller.dart';


class ProfileProfileEditRepository {

  static final controller = Get.find<ProfileProfileEditController>();

  static Future<void> uploadProfilePicture({String? imagePath}) async {
    final stopwatch = Stopwatch()..start(); // Track time
    try {
      Get.snackbar("Waiting....", "");
      controller.isLoading.value = true;

      debugPrint("📌 Upload Profile Picture Started");
      debugPrint("📂 Image Path: $imagePath");

      // Create form data
      FormData body = FormData.fromMap({
        "image": await MultipartFile.fromFile(imagePath ?? ""),
      });

      debugPrint("📝 FormData Prepared: $body");

      // Send request
      final response = await DioClient().post(
        AppUrls.uploadProfilePicture,
        data: body,
      );

      debugPrint(
          "✅ Response received in ${stopwatch.elapsedMilliseconds}ms: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        controller.isLoading.value = false;
        Get.snackbar("Success", response.data["message"] ?? "Uploaded successfully");
        debugPrint("🎉 Upload Success: ${response.data["message"]}");
        controller.selectedImage.close();
      } else {
        controller.isLoading.value = false;
        Get.snackbar(
            "Error", "Unexpected status code: ${response.statusCode}");
        debugPrint("⚠️ Unexpected Status Code: ${response.statusCode}");
      }
    } on DioError catch (e) {
      controller.isLoading.value = false;
      if (e.response != null) {
        debugPrint("❌ DioError Response Status: ${e.response?.statusCode}");
        debugPrint("❌ DioError Response Data: ${e.response?.data}");
        Get.snackbar(
            "Error", e.response?.data["message"] ?? "Unknown server error");
      } else {
        debugPrint("❌ Network or Other Error: ${e.message}");
        Get.snackbar("Error", "Network error: ${e.message}");
      }
    } catch (e, st) {
      controller.isLoading.value = false;
      debugPrint("⚠️ Unknown Exception: $e");
      debugPrint("🛠 StackTrace: $st");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      debugPrint("⏱ Upload finished in ${stopwatch.elapsedMilliseconds}ms");
      stopwatch.stop();
    }
  }

//

}