import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../core/widget/app_back_button.dart';
import '../../../../../core/widget/app_background.dart';
import '../controllers/mover_information_about_the_cancalation_cenceled_controller.dart';
import '../widget/mover_information_about_the_cancalation_cenceled_view_detais.dart';

class MoverInformationAboutTheCancalationCenceledView
    extends GetView<MoverInformationAboutTheCancalationCenceledController> {
  const MoverInformationAboutTheCancalationCenceledView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 24.h,),
              Text("Cancellation Move Details",style:textStyele.titleLarge,),
              SizedBox(height: 4.h,),
              Text("Details of a cancellation requested move.",style: textStyele.bodyMedium,),
              SizedBox(height: 24,),
              MoverInformationAboutTheCancalationCenceledViewDetais()

            ],
          ),
        ),
      ),
    );
  }
}
