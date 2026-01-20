import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/modules/auth/create_account/controllers/create_account_controller.dart';
import '../../../../core/const/app_argument_string.dart';
import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/shared_prepharence_helper.dart';
import '../../../../routes/app_pages.dart';
import '../../../role_selection/controllers/role_selection_controller.dart';
import '../controllers/verification_code_controller.dart';
class VerificationCodeRepository {
  static final controller =Get.find<VerificationCodeController>() ;
 static final roleSelectionController = Get.find<RoleSelectionController>();

  static Future<void>verfyEmail({String? isForgetPassword})async{
    try{
      controller.isLoading.value = true ;
      final  userId  = SharedPrefHelper.getString(SharedPrefHelper.userId);
      var body = {
        "userId": userId,
        "otpCode": controller.otpTextEditingController.text,
      };

      final   response = await DioClient().post(AppUrls.verfyEmail,data: body);


      if(response.statusCode == 200 || response.statusCode == 201){
        SharedPrefHelper.setString(SharedPrefHelper.accessToken, response.data["data"]["accessToken"]);
        SharedPrefHelper.setString(SharedPrefHelper.refreshToken, response.data["data"]["refreshToken"]);
        SharedPrefHelper.setString(SharedPrefHelper.userId, response.data["data"]["id"]);

        controller.isLoading.value = false;
        Get.snackbar("Success",response.data["message"]);
        if(roleSelectionController.roleSelection.value == "PROVIDER"){
          Get.toNamed(Routes.BIO);
          debugPrint("service_provider");

        }else if(AppArgumentString.forgetPassword == isForgetPassword){
          Get.toNamed(Routes.SET_NEW_PASSWORD,arguments: {
            AppArgumentString.forgetPassword :  AppArgumentString.forgetPassword
          });

        }
        else{
          Get.toNamed(Routes.LOG_IN);
        }
        debugPrint("${response.data["message"]}");
      }
    }on DioError catch (e) {
      if (e.response != null) {
        controller.isLoading.value = false ;
        Get.snackbar("Error", e.response?.data["message"] ?? "Unknown error");
        debugPrint("Error status code: ${e.response}");
      } else {
        controller.isLoading.value = false ;
        debugPrint("Network or other error: ${e.message}");
      }}}
  static Future<void>resetOtp({String? isForgetPassword})async{
    try{
      controller.isLoading.value = true ;
      final  userId  = SharedPrefHelper.getString(SharedPrefHelper.userId);
      var body = {
        "userId": userId,
        "otpCode": controller.otpTextEditingController.text,
      };


      final response = await DioClient().post(AppUrls.verifyResetPasswordotp,data: body);


      if(response.statusCode == 200 || response.statusCode == 201){
        SharedPrefHelper.setString(SharedPrefHelper.accessToken, response.data["data"]["accessToken"]);
        Get.toNamed(Routes.SET_NEW_PASSWORD,arguments: {
          AppArgumentString.forgetPassword :  AppArgumentString.forgetPassword
        });
        controller.isLoading.value = false;
        Get.snackbar("Success",response.data["message"]);

      }
    }on DioError catch (e) {
      if (e.response != null) {
        controller.isLoading.value = false ;
        Get.snackbar("Error", e.response?.data["message"] ?? "Unknown error");
        debugPrint("Error status code: ${e.response}");
      } else {
        controller.isLoading.value = false ;
        debugPrint("Network or other error: ${e.message}");
      }}}

}