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
    final controller = Get.put(OfferReviewController());
    final Map<String, dynamic>? argu = Get.arguments as Map<String, dynamic>?;
    controller.offerId = argu?[AppArgumentString.postId];
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => controller.refresh(),
        child: AppBackground(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            // padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                AppBackButton(),
                SizedBox(height: 24.h),
                Text(
                  "Offers (${argu?[AppArgumentString.offer] ?? '0'})",
                  style: textStyele.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Review all offers received from available movers.",
                  style: textStyele.bodyMedium!.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 24.h),
                MoveOfferDetails(offer: "Details", details: "Offer"),
                SizedBox(height: 16.h),
                Obx(
                  () => controller.selectedOfferDetails.value == "Offer"
                      ? Offer()
                      : Detils(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
