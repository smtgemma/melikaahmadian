import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/shared_prepharence_helper.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/log_in_controller.dart';

class LogInRepository {

  // static Future<void> login({required String email, required String password}) async {
  //   try {
  //     final body = {
  //       "email": email.trim(),
  //       "password":password,
  //     };
  //
  //     final response = await DioClient().post(AppUrls.login, data: body);
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final data = response.data["data"];
  //       await SharedPrefHelper.setString(
  //           SharedPrefHelper.accessToken, data["accessToken"]);
  //       await SharedPrefHelper.setString(
  //           SharedPrefHelper.refreshToken, data["refreshToken"]);
  //       await SharedPrefHelper.setString(
  //           SharedPrefHelper.userId, data["id"]);
  //       await SharedPrefHelper.setString(
  //           SharedPrefHelper.userRoll, data["role"]);
  //
  //       debugPrint("accessToken : ${data["accessToken"]}");
  //       debugPrint("refreshToken : ${data["refreshToken"]}");
  //       debugPrint("userId : ${data["id"]}");
  //       debugPrint("userRole : ${data["role"]}");
  //       if (data["role"] == "PROVIDER") {
  //         debugPrint("Provider");
  //
  //         Get.offAllNamed(Routes.MOVER_NAVBAR);
  //       }else{
  //         debugPrint("user");
  //         //controller.clearFields();
  //         Get.offAllNamed(Routes.NAVBAR);
  //       }
  //
  //        // better than toNamed after login
  //       Get.snackbar("Success", response.data["message"] ?? "Login successful");
  //     }
  //   }
  //   on DioException catch (e) { // Dio v5
  //     final msg = e.response?.data?["message"] ?? "Something went wrong";
  //     Get.snackbar("Error", msg);
  //     debugPrint("Dio Error: ${e.response?.statusCode} | $msg");
  //   }
  //   catch (e) {
  //     debugPrint("Unexpected error: $e");
  //     Get.snackbar("Error", "Unexpected error occurred");
  //   }
  //   finally {
  //   }
  // }

}
