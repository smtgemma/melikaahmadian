import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

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
     body: AppBackground(
       child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             AppBackButton(),
             SizedBox(height: 24,),
             Text("Ongoing Moves",style:textStyele.titleLarge,),
             SizedBox(height: 4.h,),
             Text("Details of ongoing moves & mover.",style: textStyele.bodyMedium,),
             SizedBox(height: 24.h,),
             MoveOfferDetails(offer: "Details",details: "Move Update",),
             SizedBox(height: 24.h,),
               Obx(() =>  offercontroller.selectedOfferDetails.value == "Details"  ? OngingDetails() :OngingMoveUpdate(),)
         
           ],
         
         ),
       ),
     ),
    );
  }
}
