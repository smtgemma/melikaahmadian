import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:melikaahmadian/app/core/network/shared_prepharence_helper.dart';
import 'package:melikaahmadian/app/modules/move/offer_review/model/details_model.dart';
import 'package:melikaahmadian/app/modules/move/offer_review/model/offer_model.dart';
import 'package:get/get.dart';
import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../routes/app_pages.dart';

class OfferReviewRepository {
  static Future<OfferModel> getOffer({String? pram}) async {
    try {
      var response = await DioClient().get(
        AppUrls.getOfferForSpecificPost(pram),
      );
      if (response.statusCode == 200) {
        // SharedPrefHelper.setString(SharedPrefHelper.postMoverId, response.data["data"]["postId"]);
        // final postMoverId = SharedPrefHelper.getString(SharedPrefHelper.postMoverId);
        // debugPrint("postMoverId: $postMoverId");

        return OfferModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load posts");
      }
    } on DioError catch (e) {
      debugPrint("⚠️ API Error: ${e.response?.statusCode}");
      debugPrint("⚠️ API Error Data: ${e.response?.data}");
      debugPrint("⚠️ API Error Message: ${e.message}");
      return OfferModel();
    } catch (e) {
      debugPrint("⚠️ Unknown Error: $e");
      return OfferModel();
    }
  }

  static Future<DetailsModel> getDetails({String? pram}) async {
    try {
      var response = await DioClient().get(AppUrls.getSinglePost(pram));
      if (response.statusCode == 200) {
        return DetailsModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load posts");
      }
    } on DioError catch (e) {
      debugPrint("⚠️ API Error: ${e.response?.statusCode}");
      debugPrint("⚠️ API Error Data: ${e.response?.data}");
      debugPrint("⚠️ API Error Message: ${e.message}");
      return DetailsModel();
    } catch (e) {
      debugPrint("⚠️ Unknown Error: $e");
      return DetailsModel();
    }
  }

  static Future<void> canclMove({String? id , String? reason,bool? isMover}) async {
    try {
      Get.snackbar("Wating..", "");


      var body = {
        "reason": reason,
      };
      final response = await DioClient().patch(AppUrls.cancelPost(id), data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {

          Get.toNamed(Routes.NAVBAR);




        Get.snackbar("Success", response.data["message"]);
        debugPrint("${response.data["message"]}");
      }
    } on DioError catch (e) {
      if (e.response != null) {

        Get.snackbar("Error", e.response?.data["message"] ?? "Unknown error");
        debugPrint("Error status code: ${e.response}");
      } else {
        debugPrint("Network or other error: ${e.message}");
      }
    }
  }
  static Future<void> cancelOffer({String? id , String? reason,bool? isMover}) async {
    try {
      Get.snackbar("Wating..", "");


      var body = {
        "reason": reason,
      };
      final response = await DioClient().patch(AppUrls.cancelOffer(id), data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {

          Get.toNamed(Routes.MOVER_NAVBAR);



        Get.snackbar("Success", response.data["message"]);
        debugPrint("${response.data["message"]}");
      }
    } on DioError catch (e) {
      if (e.response != null) {

        Get.snackbar("Error", e.response?.data["message"] ?? "Unknown error");
        debugPrint("Error status code: ${e.response}");
      } else {
        debugPrint("Network or other error: ${e.message}");
      }
    }
  }
}
