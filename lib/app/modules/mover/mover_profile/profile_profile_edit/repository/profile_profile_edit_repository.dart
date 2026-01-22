import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

import '../../../../../core/const/app_urls.dart';
import '../../../../../core/network/dio_client.dart';
import '../../controllers/mover_profile_controller.dart';
import '../controllers/profile_profile_edit_controller.dart';

class ProfileProfileEditRepository {
  static final controller = Get.put(ProfileProfileEditController()) ;
  //static final controller = Get.find<ProfileProfileEditController>();
  static final movercontroller = Get.find<MoverProfileController>();

    // static Future<void> uploadProfilePicture({String? imagePath}) async {
    //   final stopwatch = Stopwatch()..start(); // Track time
    //   try {
    //     Get.snackbar("Waiting....", "");
    //     controller.isLoading.value = true;
    //
    //     debugPrint("📌 Upload Profile Picture Started");
    //     debugPrint("📂 Image Path: $imagePath");
    //
    //     // Create form data
    //     FormData body = FormData.fromMap({
    //       "image": await MultipartFile.fromFile(imagePath ?? ""),
    //     });
    //
    //     debugPrint("📝 FormData Prepared: $body");
    //
    //     // Send request
    //     final response = await DioClient().post(
    //       AppUrls.uploadProfilePicture,
    //       data: body,
    //     );
    //
    //     debugPrint(
    //       "✅ Response received in ${stopwatch.elapsedMilliseconds}ms: ${response.data}",
    //     );
    //
    //     if (response.statusCode == 200 || response.statusCode == 201) {
    //       controller.isLoading.value = false;
    //       Get.snackbar(
    //         "Success",
    //         response.data["message"] ?? "Uploaded successfully",
    //       );
    //       debugPrint("🎉 Upload Success: ${response.data["message"]}");
    //       controller.selectedImage.close();
    //     } else {
    //       controller.isLoading.value = false;
    //       Get.snackbar("Error", "Unexpected status code: ${response.statusCode}");
    //       debugPrint("⚠️ Unexpected Status Code: ${response.statusCode}");
    //     }
    //   } on DioError catch (e) {
    //     controller.isLoading.value = false;
    //     if (e.response != null) {
    //       debugPrint("❌ DioError Response Status: ${e.response?.statusCode}");
    //       debugPrint("❌ DioError Response Data: ${e.response?.data}");
    //       Get.snackbar(
    //         "Error",
    //         e.response?.data["message"] ?? "Unknown server error",
    //       );
    //     } else {
    //       debugPrint("❌ Network or Other Error: ${e.message}");
    //       Get.snackbar("Error", "Network error: ${e.message}");
    //     }
    //   } catch (e, st) {
    //     controller.isLoading.value = false;
    //     debugPrint("⚠️ Unknown Exception: $e");
    //     debugPrint("🛠 StackTrace: $st");
    //     Get.snackbar("Error", "Something went wrong");
    //   } finally {
    //     debugPrint("⏱ Upload finished in ${stopwatch.elapsedMilliseconds}ms");
    //     stopwatch.stop();
    //   }
    // }
  static Future<void> uploadProfilePicture({required String imagePath}) async {
    final stopwatch = Stopwatch()..start();

    try {
      controller.isLoading.value = true;

      debugPrint("📌 Upload Profile Picture Started");

      FormData body = FormData.fromMap({
        "image": await MultipartFile.fromFile(imagePath),
      });

      final response = await DioClient().post(
        AppUrls.uploadProfilePicture,
        data: body,
      );

      Get.snackbar("Success", response.data["message"] ?? "Uploaded");

    } catch (e) {
      Get.snackbar("Error", "Upload failed");
    } finally {
      controller.isLoading.value = false;
      stopwatch.stop();
    }
  }


  static Future<void> updateNameSpecialization() async {
    controller.isupdateLoading.value = true;
    try {
      var body = {
        "fullName": movercontroller.nameTextEditingController.text,
        "specialization": movercontroller.selectedSpecialties.value,
      };
      final response = await DioClient().put(AppUrls.updateProfileNameSpecialization, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        controller.isupdateLoading.value = false;
        Get.snackbar("Success", response.data["message"]);
        debugPrint("${response.data["message"]}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        controller.isupdateLoading.value = false;
        Get.snackbar("Error", e.response?.data["message"] ?? "Unknown error");
        debugPrint("Error status code: ${e.response}");
      } else {
        controller.isupdateLoading.value = false;
        debugPrint("Network or other error: ${e.message}");
      }
    }
  }

  static Future<void> deletVehiclePhoto() async {
    controller.deleteLoading.value = true;
    try {
      final response = await DioClient().delete(AppUrls.deleteVehiclePhoto );

      if (response.statusCode == 200 || response.statusCode == 201) {
        controller.isupdateLoading.value = false;
        Get.snackbar("Success", response.data["message"]);
        debugPrint("${response.data["message"]}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        controller.isupdateLoading.value = false;
        Get.snackbar("Error", e.response?.data["message"] ?? "Unknown error");
        debugPrint("Error status code: ${e.response}");
      } else {
        controller.isupdateLoading.value = false;
        debugPrint("Network or other error: ${e.message}");
      }
    }
  }

  static Future<void> uplodvehiclePicture({String? imagePath}) async {
    final stopwatch = Stopwatch()..start(); // Track time
    try {
      controller.isupdateLoading.value = true;



      // Create form data
      FormData body = FormData.fromMap({
        "ProviderDocuments": await Future.wait(
          controller.selectedFiles.map(
                (file) => MultipartFile.fromFile(file.path),
          ),
        ),
      });

      // Send request
      final response = await DioClient().post(
        AppUrls.updateProfilevehicalPhoto,
        data: body,
      );

      debugPrint(
        "✅ Response received in ${stopwatch.elapsedMilliseconds}ms: ${response.data}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        controller.isupdateLoading.value = false;
        Get.snackbar(
          "Success",
          response.data["message"] ?? "Uploaded successfully",
        );
        debugPrint("🎉 Upload Success: ${response.data["message"]}");
        controller.selectedImage.close();
      } else {
        controller.isupdateLoading.value = false;
        Get.snackbar("Error", "Unexpected status code: ${response.statusCode}");
        debugPrint("⚠️ Unexpected Status Code: ${response.statusCode}");
      }
    } on DioError catch (e) {
      controller.isupdateLoading.value = false;
      if (e.response != null) {
        debugPrint("❌ DioError Response Status: ${e.response?.statusCode}");
        debugPrint("❌ DioError Response Data: ${e.response?.data}");
        Get.snackbar(
          "Error",
          e.response?.data["message"] ?? "Unknown server error",
        );
      } else {
        debugPrint("❌ Network or Other Error: ${e.message}");
        Get.snackbar("Error", "Network error: ${e.message}");
      }
    } catch (e, st) {
      controller.isupdateLoading.value = false;
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
