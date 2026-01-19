import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../../../setting/model/get_profile_model.dart';
import '../model/mover_profile_model.dart';
import '../profile_profile_edit/controllers/profile_profile_edit_controller.dart';


MoverProfileModel parseMoverProfileModel(dynamic json) {
  return MoverProfileModel.fromJson(json);
}

class MoverProfileRepositorysd {
  static Future<MoverProfileModel> getProfile() async {
    try {
      final response = await DioClient().get(AppUrls.getMyProfile);

      debugPrint("✅ API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return compute(parseMoverProfileModel, response.data);
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
