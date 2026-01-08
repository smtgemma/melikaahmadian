import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart'  hide FormData, MultipartFile;
import 'package:dio/io.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import '../../../../routes/app_pages.dart';
import '../../document_uplod/controllers/document_uplod_controller.dart';
import '../controllers/review_evrything_controller.dart';
class ReviewEverythingRepository {
 static final controller  = Get.find<ReviewEvrythingController>() ;
 static final uploadController = Get.find<DocumentUplodController>();


 static Future<void> submitApplication() async {
    try {
      controller.isLoading.value = true ;

      // ✅ JSON Data
      Map<String, dynamic> jsonData = {
        "bio": controller.bio,
        "specialization": controller.specilize, // this is a list
      };

      FormData formData = FormData.fromMap({
        // Send JSON as String
        "data": jsonEncode(jsonData),

        // Single files
        "drivingLicense": await MultipartFile.fromFile(
          uploadController.selectedFiles[0].path,
          filename: "license.png",
        ),

        "ownershipProof": await MultipartFile.fromFile(
          uploadController.selectedFiles[1].path,
          filename: "ownership.png",
        ),

        "insurance": await MultipartFile.fromFile(
          uploadController.selectedFiles[2].path,
          filename: "insurance.png",
        ),

        // Multiple vehicle photos
        "vehiclePhotos": controller.vehiclePhoto!
            .map((file) => MultipartFile.fromFileSync(file.path)) // this is a list
            .toList(),
      });
      final dioClass = DioClient();
      final response = await dioClass.post(
         AppUrls.providerOnbording,
        data: formData,
        onSendProgress: (sent, total) {
          if (total != -1) {
            double progress = (sent / total) * 100;
            debugPrint("📤 Upload Progress: ${progress.toStringAsFixed(0)}%");

            // If using GetX / RxDouble:
            controller.uploadProgress.value = progress.toString();
          }
        },

      );

      //final response = await  DioClient().post(AppUrls.providerOnbording, data: formData);


      debugPrint("✅ Success: ${response.data}");
      controller.isLoading.value = false ;
      if(response.statusCode == 200 || response.statusCode == 201){
        Get.snackbar("Success", response.data["message"]);
          Get.toNamed(Routes.APPLICATION_SUBMIT,arguments: {
          "null" : "null",
        });
      }

    } on DioError catch (e) {
      controller.isLoading.value = false ;
      if (e.response != null) {
        controller.isLoading.value = false ;
        Get.snackbar(
          "Error",
          e.response?.data["message"] ?? "Unknown error",
        );
        debugPrint("❌ Error response: ${e.response}");
        debugPrint("❌ Status code: ${e.response?.statusCode}");
      } else {
        controller.isLoading.value = false ;
        debugPrint("🌐 Network error: ${e.message}");
      }
    }
  }


}