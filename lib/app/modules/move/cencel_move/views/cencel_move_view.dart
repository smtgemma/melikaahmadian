import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../offer_review/controllers/offer_review_controller.dart';
import '../../ongoing_mover_details/widget/onging_details.dart';
import '../controllers/cencel_move_controller.dart';

class CencelMoveView extends GetView<CencelMoveController> {
  const CencelMoveView({super.key});
  @override
  Widget build(BuildContext context) {
    final offercontroller = Get.put(OfferReviewController());
    var textStyele = TextTheme.of(context);
    return Scaffold(
     body: AppBackground(child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         AppBackButton(),
         Center(child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(height: 222.h,),
           Text("Move Cancelation Requested",style: textStyele.titleLarge,textAlign: TextAlign.center,),
         SizedBox(height: 08.h,),
         Center(child: Text("No worries, our team will get back to you in 30 minute.",style: textStyele.bodyMedium,textAlign: TextAlign.center,)),
         SizedBox(height: 24.h,),
          AppButton(titel: "See Move Details",onPress: (){
            Get.toNamed(Routes.CENCEL_MOVER_DETAILS);


          },)
           ],
         ),)
       ],
     ),),
    );
  }
}
