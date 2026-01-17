import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../routes/app_pages.dart';
import '../views/compeleted_move.dart';
class OngoingProfileDetailsRepository {
  static Future<void> compeletedMove({String? id , String? reason}) async {
    try {
      Get.snackbar("Wating..", "");


      var body = {
        "status": "COMPLETED"
      };
      final response = await DioClient().patch(AppUrls.statusChange(id), data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.to(CompeletedMove());
        Get.snackbar("Success", response.data["message"]);
        debugPrint("${response.data["message"]}");
      }
    } on DioError catch (e) {
      if (e.response != null) {

        Get.snackbar("Error", e.response?.data["message"] ?? "Unknown error");
        debugPrint("Error status code: ${e.response}");
      } else {
        debugPrint("Network or other error: ${e.message}");
      }
    }
  }
}