import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/const/app_argument_string.dart';
import '../../offer_review/model/details_model.dart';
import '../../offer_review/repository/offer_review_repository.dart';

class OngoingMoverDetailsController extends GetxController {
  //TODO: Implement OngoingMoverDetailsController
  Rx<DetailsModel> detailsmodel = DetailsModel().obs ;
  final detailsLoading = false.obs;



  String? postId ;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    super.onInit();
    final argu = Get.arguments;
    postId = argu?[AppArgumentString.postId];
    getDetails(pram: postId);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  Future<void> getDetails({String? pram}) async {
    try {
      detailsLoading.value = true;
      var response = await OfferReviewRepository.getDetails(pram: pram);
      detailsmodel.value = response;
    } catch (e) {
      detailsLoading.value = false;
      debugPrint("offer controller catch Error: $e");

    }finally{
      detailsLoading.value = false;
    }

  }
}
