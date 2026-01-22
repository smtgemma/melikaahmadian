import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../core/const/app_colors.dart';
import '../../offer_review/controllers/offer_review_controller.dart';
import '../../offer_review/widget/move_offer_details.dart';
import '../controllers/ongoing_mover_details_controller.dart';
import '../widget/onging_details.dart';
import '../widget/onging_move_update.dart';

class OngoingMoverDetailsView extends GetView<OngoingMoverDetailsController> {
  const OngoingMoverDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final offercontroller = Get.put(OfferReviewController());
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: RefreshIndicator(
        child: AppBackground(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBackButton(),
                SizedBox(height: 24),
                Text("Ongoing Moves", style: textStyele.titleLarge),
                SizedBox(height: 4.h),
                Text(
                  "Details of ongoing moves & mover.",
                  style: textStyele.bodyMedium,
                ),
                SizedBox(height: 24.h),
                MoveOfferDetails(offer: "Details", details: "Move Update"),
                SizedBox(height: 24.h),
                Obx(() {
                  String rawDate =
                      controller.detailsmodel.value.data?.scheduleDate
                          .toString() ??
                      "";

                  // Parse and format the date safely
                  String displayDate;

                  if (rawDate.isEmpty) {
                    displayDate = "27th November 2025"; // fallback
                  } else {
                    DateTime parsedDate = DateTime.parse(rawDate);
                    displayDate = DateFormat(
                      'dd MMM yyyy',
                    ).format(parsedDate); // e.g., 25 Dec 2024
                  }
                  if (controller.detailsLoading.value == true) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secoundaryColor,
                      ),
                    );
                  }
                  if (offercontroller.selectedOfferDetails.value == "Details") {
                    return OngingDetails(
                      name:
                          controller
                              .detailsmodel
                              .value
                              .data
                              ?.acceptedOffer
                              ?.provider
                              ?.fullName
                              .toString() ??
                          "",
                      ratring:
                          controller
                              .detailsmodel
                              .value
                              .data
                              ?.acceptedOffer
                              ?.provider
                              ?.averageRating
                              .toStringAsFixed(1) ??
                          "0",
                      reviewRating:
                          controller
                              .detailsmodel
                              .value
                              .data
                              ?.acceptedOffer
                              ?.provider
                              ?.totalReviews
                              .toStringAsFixed(0)
                              .toString() ??
                          "0",
                      picAddress: controller
                          .detailsmodel
                          .value
                          .data
                          ?.pickupAddress
                          ?.address
                          .toString(),
                      dropAddress: controller
                          .detailsmodel
                          .value
                          .data
                          ?.dropoffAddress
                          ?.address
                          .toString(),
                      picLat: controller
                          .detailsmodel
                          .value
                          .data
                          ?.pickupAddress
                          ?.latitude,
                      picLong: controller
                          .detailsmodel
                          .value
                          .data
                          ?.pickupAddress
                          ?.longitude,
                      drolat: controller
                          .detailsmodel
                          .value
                          .data
                          ?.dropoffAddress
                          ?.latitude,
                      drolong: controller
                          .detailsmodel
                          .value
                          .data
                          ?.dropoffAddress
                          ?.longitude,
                      data: displayDate,
                      time: controller.detailsmodel.value.data?.scheduleTime
                          .toString(),
                      selectedType: controller
                          .detailsmodel
                          .value
                          .data
                          ?.houseType
                          .toString(),
                      listfurniture:
                          controller.detailsmodel.value.data?.furniture,
                      postId: controller.detailsmodel.value.data?.id.toString(),
                      videoPath:
                          controller.detailsmodel.value.data?.media[0].url,
                      userId: controller
                          .detailsmodel
                          .value
                          .data
                          ?.acceptedOffer
                          ?.providerId,

                 ) ;
               }else{
               return  OngingMoveUpdate(id:controller.detailsmodel.value.data?.id.toString() ,status:controller.detailsmodel.value.data?.moveStatus ?? "" ,) ;
               }})


           ],

         ),
       ),
     ), onRefresh: (){
       return controller.getDetails(pram: controller.postId);
     }),
    );
  }
}
