import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import 'package:melikaahmadian/app/modules/auth/create_account/controllers/create_account_controller.dart';
import 'package:melikaahmadian/app/modules/auth/set_new_password/controllers/set_new_password_controller.dart';
import 'package:melikaahmadian/app/modules/role_selection/controllers/role_selection_controller.dart';

import '../../../../core/network/shared_prepharence_helper.dart';
import '../../../../routes/app_pages.dart';
import '../../create_account_with_email/controllers/create_account_with_email_controller.dart';
class SignUpRepository {
  static final setPassController = Get.put(SetNewPasswordController());
  static final createAccountController = Get.find<CreateAccountWithEmailController>();
  static final rollselectionController = Get.put(RoleSelectionController());

  static Future<void>signIn()async{
    try{
      setPassController.isLoading.value = true ;
      var body = {
        "fullName": createAccountController.nameTextEdittingController.text,
        "email": createAccountController.emailTextEdittingController.text,
        "password":    setPassController.confrimePassTextEditingController.text,
        "phone": createAccountController.selectedCountryCode.value + createAccountController.phoneTextEdittingController.text.trim(),
        "role": rollselectionController.roleSelection.value,
        //PROVIDER
      } ;
      final response = await DioClient().post(AppUrls.createAccount,data: body)  ;
        if(response.statusCode == 200 || response.statusCode == 201){
          setPassController.isLoading.value = false;
          Get.snackbar("Success","OTP sent. Please check your email.");
          debugPrint("sign in id ${response.data["data"]["id"]}");
         await SharedPrefHelper.setString(SharedPrefHelper.userId, response.data["data"]["id"]);
          final userId = await SharedPrefHelper.getString(SharedPrefHelper.userId);
          debugPrint("sign in userid $userId");
          Get.toNamed(Routes.VERIFICATION_CODE,arguments: {"email":setPassController.email,});
          debugPrint("${response.data["message"]}");
      }
    }on DioError catch (e) {
      if (e.response != null) {
        setPassController.isLoading.value = false ;
        Get.snackbar("Error", e.response?.data["message"] ?? "Unknown error");
        debugPrint("Error status code: ${e.response}");
      } else {
        setPassController.isLoading.value = false ;
        debugPrint("Network or other error: ${e.message}");
      }}}
  static Future<void> changePassword() async {
    try {
      setPassController.isLoading.value = true;

      final body = {
        "newPassword":
        setPassController.confrimePassTextEditingController.text.trim(),
      };

      final response = await DioClient().post(
        AppUrls.resetPassword,
        data: body,

      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", response.data["message"]);
        Get.offAllNamed(Routes.LOG_IN);
      }
    } on DioError catch (e) {
      setPassController.isLoading.value = false;

      if (e.response != null) {
        Get.snackbar("Error", e.response?.data["message"] ?? "Unknown error");
        debugPrint("Error: ${e.response?.data}");
      } else {
        debugPrint("Network error: ${e.message}");
      }
    } finally {
      setPassController.isLoading.value = false;
    }
  }





}