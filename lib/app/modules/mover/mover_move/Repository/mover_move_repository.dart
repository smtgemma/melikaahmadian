import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../../../move/model/move_model.dart';
import '../model/mover_move_model.dart';

class MoverMoveRepository {
  static Future<MoverMoveModel> getMoves({String? pram}) async {
    try {
      String? url ;
      if(pram == null){
        url = AppUrls.get_my_offer ;
      }else{
        url = AppUrls.get_my_offer + "?status=${pram}";
      }
      var response = await DioClient().get(url);
      if(response.statusCode == 200){
        return MoverMoveModel.fromJson(response.data);
      }else{
        throw Exception("Failed to load posts");

      }
    }on DioError catch (e) {
      debugPrint("⚠️ API Error: ${e.response?.statusCode}");
      debugPrint("⚠️ API Error Data: ${e.response?.data}");
      // Get.snackbar("Error", "Something Went Wrong");
      debugPrint("⚠️ API Error Message: ${e.message}");
      return MoverMoveModel();
    } catch (e) {

      debugPrint("⚠️ Unknown Error: $e");
      return MoverMoveModel();
    }
  }
}