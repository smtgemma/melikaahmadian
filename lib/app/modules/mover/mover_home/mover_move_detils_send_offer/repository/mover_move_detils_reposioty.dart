import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/const/app_argument_string.dart';
import '../../../../../core/const/app_urls.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../routes/app_pages.dart';
import '../controllers/mover_move_detils_send_offer_controller.dart';

class MoverMoveDetilsReposioty {
  static final controller = Get.find<MoverMoveDetilsSendOfferController>();

  static Future<void> sendOffer({String? postId}) async {
    try {
      debugPrint("sendOffer ${controller.postId}");
      controller.isLoading.value = true;
      int price = int.parse(controller.priceEditinController.text.trim());

      var body = {
        "offerPrice":price ,
        "postId": postId ?? ""
      };
      final response = await DioClient().post(AppUrls.sendOffer, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        controller.isLoading.value = false;
        Get.toNamed(Routes.APPLICATION_SUBMIT,arguments: {
          AppArgumentString.moverSendOffer : AppArgumentString.moverSendOffer
        });
        Get.snackbar("Success", response.data["message"]);
        debugPrint("${response.data["message"]}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        controller.isLoading.value = false;
        Get.snackbar("Error", e.response?.data["message"] ?? "Unknown error");
        debugPrint("Error status code: ${e.response}");
      } else {
        controller.isLoading.value = false;
        debugPrint("Network or other error: ${e.message}");
      }
    }
  }
}
