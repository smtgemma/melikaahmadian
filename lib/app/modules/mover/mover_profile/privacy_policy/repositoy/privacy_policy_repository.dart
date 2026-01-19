
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/const/app_urls.dart';
import '../../../../../core/network/dio_client.dart';
import '../../terms_condition/model/terms_condition_model.dart';

class PrivacyPolicyRepository {

  static Future<TermsConditionModel> privacyPolicy() async {
    try {
      final response = await DioClient().get(AppUrls.privacyAndPolicy);

      debugPrint("✅ API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TermsConditionModel.fromJson(response.data);
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