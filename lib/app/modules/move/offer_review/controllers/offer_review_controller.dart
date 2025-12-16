import 'package:get/get.dart';

class OfferReviewController extends GetxController {
  //TODO: Implement OfferReviewController

  final offer = 1.obs;
  final details = 0.obs;

  final selectedOfferDetails = "".obs ;

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

  void offerDetailsControole(){
    if(offer.value == 1){
      offer.value = 0 ;
      details.value = 1 ;
    }else{
      offer.value = 1 ;
      details.value = 0 ;
    }

  }


}
