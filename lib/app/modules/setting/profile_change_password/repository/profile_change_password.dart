import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../controllers/profile_change_password_controller.dart';

class ProfileChangePassword {
  static final controller = Get.find<ProfileChangePasswordController>();

  static Future<void> chnagePassword() async {
    try {
      controller.isLoading.value = true;

      var body = {
        "oldPassword": controller.oldPassTextEditingController.text,
        "newPassword": controller.confrimePassTextEditingController.text
      };
      final response = await DioClient().post(AppUrls.chnagePassword, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        controller.isLoading.value = false;
        Get.toNamed(Routes.NAVBAR);
        Get.snackbar("Success", response.data["message"]);
        controller.passTextEditingController.clear();
        controller.confrimePassTextEditingController.clear();
        controller.oldPassTextEditingController.clear();

        debugPrint("${response.data["message"]}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        controller.isLoading.value = false;
        Get.snackbar("Error", e.response?.data["message"] ?? "Unknown error");
        debugPrint("Error status code: ${e.response}");
      } else {
        controller.isLoading.value = false;
        debugPrint("Network or other error: ${e.message}");
      }
    }
  }
}
