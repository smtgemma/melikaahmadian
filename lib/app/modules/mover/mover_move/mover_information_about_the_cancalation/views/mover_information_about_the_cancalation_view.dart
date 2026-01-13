import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../core/widget/App_button.dart';
import '../../../../../core/widget/app_back_button.dart';
import '../../../../../core/widget/app_background.dart';
import '../../../../../routes/app_pages.dart';
import '../controllers/mover_information_about_the_cancalation_controller.dart';

class MoverInformationAboutTheCancalationView
    extends GetView<MoverInformationAboutTheCancalationController> {
  const MoverInformationAboutTheCancalationView({super.key});
  @override
  Widget build(BuildContext context) {
   // final offercontroller = Get.put(OfferReviewController());
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
              Text("Move Cancelation Requested By Client",style: textStyele.titleLarge,textAlign: TextAlign.center,),
              SizedBox(height: 08.h,),
              Center(child: Text("No worries, our team will get back to you in 30 minute.",style: textStyele.bodyMedium,textAlign: TextAlign.center,)),
              SizedBox(height: 24.h,),
              AppButton(titel: "See Move Details",onPress: (){
                Get.toNamed(Routes.MOVER_INFORMATION_ABOUT_THE_CANCALATION_CENCELED);


              },)
            ],
          ),)
        ],
      ),),
    );
  }
}
