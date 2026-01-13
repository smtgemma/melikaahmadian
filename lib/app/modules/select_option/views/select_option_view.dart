import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../../generated/assets.dart';
import '../../../core/widget/App_button.dart';
import '../../../core/widget/app_background.dart';
import '../controllers/select_option_controller.dart';

class SelectOptionView extends GetView<SelectOptionController> {
  const SelectOptionView({super.key});
  @override
  Widget build(BuildContext context) {

    var textStyle = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(height: 16.h,),
            Center(child: Image.asset(Assets.imagesTruck)),
            SizedBox(height: 26.h,),
            Text( "MOVEFORCE", style: textStyle.headlineLarge!.copyWith(fontSize: 32.sp)),
            SizedBox(height: 8.h,),
            Expanded(child: Text("Moving has never been this simple. Captureyour items and let our movers do the lifting.",textAlign: TextAlign.center, style: textStyle.bodyMedium,)),

            Spacer(),
            AppButton(titel: "Sign Up",onPress: (){Get.toNamed(Routes.ROLE_SELECTION);},),
            SizedBox(height: 12.h,),
            AppButton(titel: "Log In",containerColor: 1,onPress: (){Get.toNamed(Routes.LOG_IN);},),
            SizedBox(height: 20.h,),

          ],
        ),),
    );

  }
}
