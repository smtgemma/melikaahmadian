import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../core/widget/app_back_button.dart';
import '../../../../../core/widget/app_background.dart';
import '../../../../move/offer_review/controllers/offer_review_controller.dart';
import '../../../../move/offer_review/widget/move_offer_details.dart';
import '../../../../move/ongoing_mover_details/widget/onging_details.dart';
import '../../../../move/ongoing_mover_details/widget/onging_move_update.dart';
import '../controllers/mover_move_detils_controller.dart';
import '../widget/mover_move_detils.dart';
import '../widget/update_status.dart';

class MoverMoveDetilsView extends GetView<MoverMoveDetilsController> {
  const MoverMoveDetilsView({super.key});
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
              Text("Ongoing Move Details",style:textStyele.titleLarge,),
              SizedBox(height: 4.h,),
              Text("Details of a particular move.",style: textStyele.bodyMedium,),
              SizedBox(height: 24.h,),
              MoveOfferDetails(offer: "Details",details: "Update Status",),
              SizedBox(height: 24.h,),
              Obx(() =>  offercontroller.selectedOfferDetails.value == "Details"  ? MoverMoveDetils(isRequestButton: true,) :UpdateStatus(),)
            ],

          ),
        ),
      ),
    );
  }
}
