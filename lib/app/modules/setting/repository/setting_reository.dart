import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import 'package:melikaahmadian/app/modules/setting/model/get_profile_model.dart';

class SettingReository {

  static Future<GetProfileModel> getProfile() async {
    try {
      final response = await DioClient().get(AppUrls.getMyProfile);

      debugPrint("✅ API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return GetProfileModel.fromJson(
          response.data as Map<String, dynamic>,
        );
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









}