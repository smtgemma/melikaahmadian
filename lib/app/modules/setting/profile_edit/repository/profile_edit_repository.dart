import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/setting_controller.dart';
import '../controllers/profile_edit_controller.dart';

class ProfileEditRepository {
  static final controller = Get.find<ProfileEditController>();
  static final settingcontroller = Get.find<SettingController>();


  static Future<void> updateProfile() async {
    try {
      controller.isLoading.value = true;

      var body ={
        "fullName": controller.nameController.text,
        "phone": controller.phoneController.text,
      };
      final response = await DioClient().put(AppUrls.updateProfile, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        controller.isLoading.value = false;
        settingcontroller.getProfile();
        Get.snackbar("Success", response.data["message"]);
        Get.toNamed(Routes.NAVBAR) ;
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
