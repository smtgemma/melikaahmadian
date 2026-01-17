import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:melikaahmadian/app/modules/move/mover_profiel_details/model/porfile_model.dart';

import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/shared_prepharence_helper.dart';
import '../model/review_model.dart';

class MoverProfileRepository {
  static Future<ProfileModel> getDetails({String? id}) async {
    try {
      final postMoverId = SharedPrefHelper.getString(SharedPrefHelper.postMoverId);
      debugPrint("postMoverId: $postMoverId");
      var response = await DioClient().get(AppUrls.getUserProfileId(postMoverId));
      if(response.statusCode == 200){
        return ProfileModel.fromJson(response.data);
      }else{
        throw Exception("Failed to load posts");

      }
    }on DioError catch (e) {
      debugPrint("⚠️ API Error: ${e.response?.statusCode}");
      debugPrint("⚠️ API Error Data: ${e.response?.data}");
      debugPrint("⚠️ API Error Message: ${e.message}");
      return ProfileModel();
    } catch (e) {

      debugPrint("⚠️ Unknown Error: $e");
      return ProfileModel();
    }
  }
  static Future<ReviewModel> getReview({String? id}) async {
    try {
      final postMoverId = SharedPrefHelper.getString(SharedPrefHelper.postMoverId);
      debugPrint("postMoverId: $postMoverId");
      var response = await DioClient().get(AppUrls.getReviewByUser(postMoverId));
      if(response.statusCode == 200){
        return ReviewModel.fromJson(response.data);
      }else{
        throw Exception("Failed to load posts");

      }
    }on DioError catch (e) {
      debugPrint("⚠️ API Error: ${e.response?.statusCode}");
      debugPrint("⚠️ API Error Data: ${e.response?.data}");
      debugPrint("⚠️ API Error Message: ${e.message}");
      return ReviewModel();
    } catch (e) {
      debugPrint("⚠️ Unknown Error: $e");
      return ReviewModel();
    }
  }

}