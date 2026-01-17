import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:melikaahmadian/app/core/network/dio_client.dart';

import '../../../../core/const/app_urls.dart';
import '../../video_cmera/controllers/video_cmera_controller.dart';
import '../controllers/add_details_controller.dart';

class AddDetailsRepository {
  static final controller = Get.find<VideoCmeraController>();
  static final addcontroller = Get.find<AddDetailsController>();


  static Future<void> aiGenaredVideo() async {
    final videoPath = controller.videoPath.value;
    debugPrint("video path" + controller.videoPath.value);
    FormData formData = FormData.fromMap({
      "video_file" : await MultipartFile.fromFile(videoPath),
      "home_type" : addcontroller.selectedDateText,
      "room_count" : 2
    });

    for(var fie in formData.fields) {
      debugPrint("formData" + fie.toString());
    }

    try{
      addcontroller.isLoading.value = true ;
      final response = await DioClient().post(AppUrls.analyzVideo, data: formData,duration: Duration(minutes: 5) ) ;
      if(response.statusCode == 200 || response.statusCode == 201){
        addcontroller.isLoading.value = false ;
        Get.snackbar("Success", response.data["message"]);
        debugPrint("Success");

      }


    }on DioError catch (e) {
      addcontroller.isLoading.value = false ;
      if (e.response != null) {

        debugPrint("Error status code: ${e.response}");
      } else {
        debugPrint("Network or other error: ${e.message}");
      }

    }

  //   if (videoPath.isEmpty) {
  //     debugPrint(" No video selected");
  //     return;
  //   }
  //
  //   final file = File(videoPath);
  //
  //   if (!await file.exists()) {
  //     debugPrint(" Video file not found");
  //     return;
  //   }
  //
  //   final bytes = await file.length(); // in bytes
  //   final mb = bytes / (1024 * 1024);
  //
  //   debugPrint("🎥 Video size: ${mb.toStringAsFixed(2)} MB");
  //
  //
  //
  //
  //
  //
  //   if (mb > 10) {
  //     debugPrint("Video is larger than 10 MB");
  //
  //     // show error to user
  //     Get.snackbar(
  //       "Video too large",
  //       "Please upload a 30–60 sec video for best AI results",
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     return;
  //   }
  //
  //   // ✅ Video size OK — continue upload / AI process
  //   debugPrint("✅ Video accepted");
  //
  // }}
}}
