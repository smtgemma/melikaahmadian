import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../../core/widget/app_back_button.dart';
import '../../../../core/widget/app_background.dart';
import '../controllers/verification_code_controller.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeView extends GetView<VerificationCodeController> {
  const VerificationCodeView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyle = TextTheme.of(context);
    return Scaffold(
      body:AppBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 100.h,),
              Text("Enter verification code ",style: textStyle.headlineLarge,),
              SizedBox(height: 08.h,),
              Text("Enter 4 digit verification code we sent.",style: textStyle.bodyMedium,),
              SizedBox(height: 24.h,),
              Align(
                alignment: Alignment.center,
                child: Pinput(
                  keyboardType: TextInputType.number,
                  length: 4,
                ),
              ),




              SizedBox(height: 24.h,),
             AppButton(titel: "Continue",onPress: (){
               Get.toNamed(Routes.SET_NEW_PASSWORD);
             },)






            ],
          ),
        ),),
    );
  }
}
