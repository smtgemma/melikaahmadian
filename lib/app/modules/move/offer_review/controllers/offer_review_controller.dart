import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';
import 'package:melikaahmadian/app/modules/move/offer_review/model/details_model.dart';
import 'package:melikaahmadian/app/modules/move/offer_review/model/offer_model.dart';

import '../repository/offer_review_repository.dart';

class OfferReviewController extends GetxController {
  //TODO: Implement OfferReviewController

  final offer = 0.obs;
  final details = 1.obs;
  final offerLoading = false.obs;
  final detailsLoading = false.obs;

  final selectedOfferDetails = "Details".obs;

  Rx<OfferModel> offerModel = OfferModel().obs ;
  Rx<DetailsModel> detailsmodel = DetailsModel().obs ;

  String? offerId ;
  String? postMoveId ;

  RxList<String> cancelMove = [
    "Wrong address added",
    "Wrong item video",
    "Not needed anymore",
    "Mover delay",
    "Mover unresponsive"
  ].obs;


  @override
  void onInit() {
    //postMoveId =

    super.onInit();
    getOffer(pram: offerId);
    getDetails(pram: offerId);
    selectedOfferDetails.value = "Details";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<OfferReviewController>();
    super.onClose();
  }

  void offerDetailsControole({int? isoffer, int? isdetails}) {
    if (isoffer == 1) {
      offer.value = 0;
      details.value = 1;
    } else if (isdetails == 1) {
      offer.value = 1;
      details.value = 0;
    }
  }
  Future<void> refresh ()async{
    getOffer(pram: offerId);
    getDetails(pram: offerId);
  }
  Future<void> accpectRefresh ()async{
    // getOffer(pram: offerId);
    getDetails(pram: offerId);
  }

  Future<void> getOffer({String? pram}) async {
    try {
      offerLoading.value = true;
      var response = await OfferReviewRepository.getOffer(pram: pram);
      offerModel.value = response;
    } catch (e) {
      offerLoading.value = false;
      debugPrint("offer controller catch Error: $e");

    }finally{
      offerLoading.value = false;
    }

  }
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
