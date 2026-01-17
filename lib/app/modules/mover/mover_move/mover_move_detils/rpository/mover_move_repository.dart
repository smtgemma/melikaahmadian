import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:melikaahmadian/app/modules/mover/mover_move/model/status_model.dart';

import '../../../../../core/const/app_urls.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../move/offer_review/model/details_model.dart';
import '../../model/mover_move_details.dart';


class MoverMoveDetailsRepository {

  static Future<MoverMoveDetailsModel> getDetails({String? pram}) async {
    try {
      var response = await DioClient().get(AppUrls.getOfferForSpecificPost(pram));
      if (response.statusCode == 200) {
        return MoverMoveDetailsModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load posts");
      }
    } on DioError catch (e) {
      debugPrint("⚠️ API Error: ${e.response?.statusCode}");
      debugPrint("⚠️ API Error Data: ${e.response?.data}");
      debugPrint("⚠️ API Error Message: ${e.message}");
      return MoverMoveDetailsModel();
    } catch (e) {
      debugPrint("⚠️ Unknown Error: $e");
      return MoverMoveDetailsModel();
    }
  }

  static Future<MoverStatusModel> getStatus({String? pram}) async {
    try {
      var response = await DioClient().get(AppUrls.getMoveStatus(pram));
      if (response.statusCode == 200) {
        return MoverStatusModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load posts");
      }
    } on DioError catch (e) {
      debugPrint("⚠️ API Error: ${e.response?.statusCode}");
      debugPrint("⚠️ API Error Data: ${e.response?.data}");
      debugPrint("⚠️ API Error Message: ${e.message}");
      return MoverStatusModel();
    } catch (e) {
      debugPrint("⚠️ Unknown Error: $e");
      return MoverStatusModel();
    }
  }

}