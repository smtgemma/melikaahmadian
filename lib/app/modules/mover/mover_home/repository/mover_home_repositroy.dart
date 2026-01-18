import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';

import '../../../../core/network/dio_client.dart';
import '../../../move/model/move_model.dart';
import '../model/all_post_model.dart';

class MoverHomeRepositroy {
  static Future<AllPostModel> getMoves({String? pram}) async {
    try {

      var response = await DioClient().get(AppUrls.post);
      if(response.statusCode == 200){
        return AllPostModel.fromJson(response.data);
      }else{
        throw Exception("Failed to load posts");

      }
    }on DioError catch (e) {
      debugPrint("⚠️ API Error: ${e.response?.statusCode}");
      debugPrint("⚠️ API Error Data: ${e.response?.data}");
      // Get.snackbar("Error", "Something Went Wrong");
      debugPrint("⚠️ API Error Message: ${e.message}");
      return AllPostModel();
    } catch (e) {

      debugPrint("⚠️ Unknown Error: $e");
      return AllPostModel();
    }
  }

}