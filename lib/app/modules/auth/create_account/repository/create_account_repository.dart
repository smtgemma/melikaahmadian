import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/shared_prepharence_helper.dart';
import '../../../role_selection/controllers/role_selection_controller.dart';
import '../controllers/create_account_controller.dart';
class CreateAccountRepository {
  static final controller = Get.find<CreateAccountController>();

  static Future<void>verfyEmail()async{
    try{
      controller.isLoading.value = true ;
      
      var body = {
        "email": controller.emailTextEditingController.text,
      };
      final response = await DioClient().post(AppUrls.forget_password,data: body)  ;
      if(response.statusCode == 200 || response.statusCode == 201){
        SharedPrefHelper.setString(SharedPrefHelper.userId, response.data["data"]["id"]);
        Get.toNamed(Routes.VERIFICATION_CODE,arguments: {
          AppArgumentString.forgetPassword : AppArgumentString.forgetPassword
        }) ;

        controller.isLoading.value = false;
        Get.snackbar("Success",response.data["message"]);}
        
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