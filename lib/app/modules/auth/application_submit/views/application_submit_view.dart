import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/modules/auth/application_submit/widget/application.dart';
import 'package:melikaahmadian/app/modules/auth/application_submit/widget/mover.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../../../core/const/app_argument_string.dart';
import '../controllers/application_submit_controller.dart';
import '../widget/mark_compeleted.dart';
import '../widget/mover_send_offer.dart';
import '../widget/payment.dart';

class ApplicationSubmitView extends GetView<ApplicationSubmitController> {
  const ApplicationSubmitView({super.key});
  @override
  Widget build(BuildContext context) {

    var argu = Get.arguments ;

    return Scaffold(
     body: AppBackground(child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         AppBackButton(),
         SizedBox(height: 82.h,),
         Image.asset(Assets.iconsCongralation),
         SizedBox(height: 24.h,),
         argu[AppArgumentString.mover] == AppArgumentString.mover ? Mover() :
         argu[AppArgumentString.payment] == AppArgumentString.payment ? Payment() :
         argu[AppArgumentString.markAsCompleted] == AppArgumentString.markAsCompleted ? MarkCompeleted() :
         argu[AppArgumentString.moverSendOffer] == AppArgumentString.moverSendOffer ?   MoverSendOffer(): Application()],
     ),),
    );
  }
}
