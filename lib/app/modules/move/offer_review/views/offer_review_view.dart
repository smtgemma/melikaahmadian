import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/modules/move/offer_review/widget/offer.dart';

import '../../../../core/const/app_argument_string.dart';
import '../controllers/offer_review_controller.dart';
import '../widget/detils.dart';
import '../../mover_profiel_details/widget/experence_box.dart';
import '../widget/move_offer_details.dart';

class OfferReviewView extends GetView<OfferReviewController> {
  const OfferReviewView({super.key});
  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic>? argu = Get.arguments as Map<String, dynamic>?;
    controller.offerId = argu?[AppArgumentString.postId];


    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 24.h,),
            Text("Offers (${argu?[AppArgumentString.offer]})",style: textStyele.titleLarge,),
            Text("Offers (${controller.offerId})",style: textStyele.titleLarge,),
            SizedBox(height: 04.h,),
            Text("Offers you received from Different movers.",style: textStyele.bodyMedium,),
            SizedBox(height: 12.h,),
            MoveOfferDetails(),
            SizedBox(height: 12.h,),
            Obx(() => controller.selectedOfferDetails.value == "offer" ? Offer() : Detils(),),



          ],
        ),
      ),
    );
  }
}
