import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';

class OfferReviewController extends GetxController {
  //TODO: Implement OfferReviewController

  final offer = 0.obs;
  final details = 1.obs;

  final selectedOfferDetails = "offer".obs ;


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void offerDetailsControole({int? isoffer,int? isdetails}){
    if(isoffer == 1){
      offer.value = 0 ;
      details.value = 1;
    }else if(isdetails == 1){
      offer.value = 1 ;
      details.value = 0 ;
    }

  }


}
