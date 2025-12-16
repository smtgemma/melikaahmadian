import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:get/get.dart';

import '../controllers/offer_review_controller.dart';
class MoveOfferDetails extends StatelessWidget {
  const MoveOfferDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OfferReviewController>() ;
    return Container(
      height: 44.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.secoundaryColor)
      ),
      child: Expanded(child: Row(
        children: [
         Obx(() =>  Expanded(child: AppButton(containerColor: controller.offer.value,titel: "Offers",onPress: (){
           controller.selectedOfferDetails.value = "offer" ;
           debugPrint(controller.selectedOfferDetails.value);
           controller.offerDetailsControole() ;
         },)),),
          Obx(() => Expanded(child: AppButton(containerColor: controller.details.value,titel: "Details",onPress: (){
            controller.selectedOfferDetails.value = "details" ;
            debugPrint(controller.selectedOfferDetails.value);
            controller.offerDetailsControole();
          },)),)
        ],
      )),

    );
  }
}
