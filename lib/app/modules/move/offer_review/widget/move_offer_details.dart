import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:get/get.dart';

import '../controllers/offer_review_controller.dart';
class MoveOfferDetails extends StatelessWidget {
  String? offer;
  String? details ;
   MoveOfferDetails({super.key,this.offer,this.details});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OfferReviewController>();
    return Container(
      height: 44.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.secoundaryColor)
      ),
      child: Row(
        children: [
         Obx(() =>  Expanded(child: AppButton(containerColor: controller.offer.value,titel: offer ?? "Details",onPress: (){
           controller.selectedOfferDetails.value = offer ?? "Details" ;
           debugPrint(controller.selectedOfferDetails.value);
           controller.offerDetailsControole(isoffer: 1);
           controller.getOffer(pram: controller.offerId);
         },)),),
          Obx(() => Expanded(child: AppButton(containerColor: controller.details.value,titel: details ?? "Offer",onPress: (){
            controller.selectedOfferDetails.value = details ?? "Offer" ;
            debugPrint(controller.selectedOfferDetails.value);
            controller.offerDetailsControole(isdetails: 1);
            controller.getDetails(pram: controller.offerId);
          },)),)
        ],
      ),

    );
  }
}
