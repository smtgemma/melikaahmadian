import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/const/app_urls.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../mover_profile/repository/mover_profile_repository.dart';
import '../../model/all_post_model.dart';
import '../model/mover_searse_post_model.dart';

MoverSearsePostModel getAddress(Map<String, dynamic> json) {
  return MoverSearsePostModel.fromJson(json);
}

AllPostModel parseAllPostModel(dynamic json) {
  return AllPostModel.fromJson(json);
}




class MoverSearsePostRepositoy {

  static Future<MoverSearsePostModel> getProfile() async {
    try {
      final response = await DioClient().get(AppUrls.getAddress);

      debugPrint("✅ API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
         return MoverSearsePostModel.fromJson(response.data);

      } else {
        throw Exception("API Failed: ${response.data}");
      }
    } on DioError catch (e) {
      debugPrint("Dio Error: ${e.message}");
      debugPrint("Status Code: ${e.response?.statusCode}");
      debugPrint("❌ Response Data: ${e.response?.data}");
      rethrow;
    } catch (e) {
      debugPrint("❌ Unknown Error: $e");
      rethrow;
    }
  }


  static Future<AllPostModel> searchAddress({String? pickupState, String? dropoffState, String? pickupCity, String? dropoffCity}) async {
    try {
      final response = await DioClient().get(AppUrls.searchAddress(dropoffCity:dropoffCity ,dropoffState:dropoffState ,pickupCity:pickupCity ,pickupState: pickupState), );

      if (response.statusCode == 200) {
        // ✅ parse in isolate
        return compute(parseAllPostModel, response.data);
      } else {
        throw Exception("Failed to load posts");
      }

    } on DioError catch (e) {
      debugPrint("⚠️ API Error: ${e.response?.statusCode}");
      debugPrint("⚠️ API Error Data: ${e.response?.data}");
      debugPrint("⚠️ API Error Message: ${e.message}");
      return AllPostModel(data: []);
    } catch (e) {
      debugPrint("⚠️ Unknown Error: $e");
      return AllPostModel(data: []);
    }
  }
}
