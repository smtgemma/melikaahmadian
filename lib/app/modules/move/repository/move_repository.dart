import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/modules/move/model/move_model.dart';

import '../../../core/network/dio_client.dart';


class MoveRepository {

  static Future<MoveModel> getMoves({String? pram}) async {
    try {
      String? url ;
      if(pram == null){
        url = AppUrls.my_post ;
      }else{
        url = AppUrls.my_post + "?status=${pram}";
      }
      var response = await DioClient().get(url);
      if(response.statusCode == 200){
        return MoveModel.fromJson(response.data);
      }else{
        throw Exception("Failed to load posts");

      }
  }on DioError catch (e) {
    debugPrint("⚠️ API Error: ${e.response?.statusCode}");
    debugPrint("⚠️ API Error Data: ${e.response?.data}");
   // Get.snackbar("Error", "Something Went Wrong");
    debugPrint("⚠️ API Error Message: ${e.message}");
    return MoveModel();
  } catch (e) {

    debugPrint("⚠️ Unknown Error: $e");
    return MoveModel();
  }
}


}