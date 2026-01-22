import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import 'package:melikaahmadian/app/core/network/shared_prepharence_helper.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../../core/const/app_colors.dart';

class LogInController extends GetxController {
  final emailTextEditingController = TextEditingController();
  final passTextEditingController = TextEditingController();
  final isVisibility = false.obs;
  final isLoading = false.obs;
  final isTermsAccepted = false.obs; // Add this
  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    clearFields();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> login({required String email, required String password}) async {
    // Check if terms are accepted
    if (!isTermsAccepted.value) {
      Get.snackbar(
        "Terms Required",
        "Please accept the terms and conditions to continue",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      final body = {"email": email.trim(), "password": password};

      final response = await DioClient().post(AppUrls.login, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data["data"];
        await SharedPrefHelper.setString(
          SharedPrefHelper.accessToken,
          data["accessToken"],
        );
        await SharedPrefHelper.setString(
          SharedPrefHelper.refreshToken,
          data["refreshToken"],
        );
        await SharedPrefHelper.setString(SharedPrefHelper.userId, data["id"]);
        await SharedPrefHelper.setString(
          SharedPrefHelper.userRoll,
          data["role"],
        );

        debugPrint("accessToken : ${data["accessToken"]}");
        debugPrint("refreshToken : ${data["refreshToken"]}");
        debugPrint("userId : ${data["id"]}");
        debugPrint("userRole : ${data["role"]}");

        if (data["role"] == "PROVIDER") {
          debugPrint("Provider");
          Get.offAllNamed(Routes.MOVER_NAVBAR);
        } else {
          debugPrint("user");
          Get.offAllNamed(Routes.NAVBAR);
        }

        Get.snackbar("Success", response.data["message"] ?? "Login successful");
        isLoading.value = false;
        clearFields();
      }
    } on DioException catch (e) {
      final msg = e.response?.data?["message"] ?? "Something went wrong";
      Get.snackbar("Error", msg);
      debugPrint("Dio Error: ${e.response?.statusCode} | $msg");
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint("Unexpected error: $e");
      Get.snackbar("Error", "Unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> socialLogin(String token) async {
    try {
      logger.i("Starting social login process with backend...");
      final networkCaller = DioClient();

      final response = await networkCaller.post(
        AppUrls.loginWithGoogle,
        data: {"idToken": token},
      );

      logger.i("Social Login Response Status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        logger.i('Social Login Success ✅');

        await SharedPrefHelper.setString(
          SharedPrefHelper.accessToken,
          data['data']['accessToken'],
        );
        await SharedPrefHelper.setString(
          SharedPrefHelper.refreshToken,
          data['data']['refreshToken'],
        );

        Get.offAllNamed(Routes.MOVER_NAVBAR);
      } else {
        logger.e("Social Login Failed ❌ => ${response.statusMessage}");
      }
    } catch (e, stackTrace) {
      logger.e(
        "Exception during social login ❌",
        error: e,
        stackTrace: stackTrace,
      );
    } finally {}
  }

  void clearFields() {
    emailTextEditingController.clear();
    passTextEditingController.clear();
    isTermsAccepted.value = false; // Reset checkbox
  }

  void visibility() {
    isVisibility.value = !isVisibility.value;
  }

  void toggleTerms() {
    isTermsAccepted.value = !isTermsAccepted.value;
  }
}
