import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/shared_prepharence_helper.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/log_in_controller.dart';

class LogInRepository {
  static final controller = Get.find<LogInController>();

  static Future<void> login() async {
    try {
      controller.isLoading.value = true;

      var body = {"email": controller.emailTextEditingController.text, "password": controller.passTextEditingController.text};
      final response = await DioClient().post(AppUrls.login, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        controller.isLoading.value = false;
        SharedPrefHelper.setString(SharedPrefHelper.accessToken, response.data["data"]["accessToken"]);
        SharedPrefHelper.setString(SharedPrefHelper.refreshToken, response.data["data"]["refreshToken"]);
        SharedPrefHelper.setString(SharedPrefHelper.userId, response.data["data"]["id"]);
        SharedPrefHelper.setString(SharedPrefHelper.userRoll, response.data["data"]["role"]);

        final accessToken = SharedPrefHelper.getString(SharedPrefHelper.accessToken);
        final refreshToken = SharedPrefHelper.getString(SharedPrefHelper.refreshToken);
        final userId = SharedPrefHelper.getString(SharedPrefHelper.userId);
        final userRoll = SharedPrefHelper.getString(SharedPrefHelper.userRoll);

        debugPrint("accessToken : $accessToken");
        debugPrint("refreshToken : $refreshToken");
        debugPrint("userId : $userId");
        debugPrint("userRoll : $userRoll");
         Get.toNamed(Routes.NAVBAR);
        Get.snackbar("Success", response.data["message"]);
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
