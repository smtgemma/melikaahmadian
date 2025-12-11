// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../controllers/role_selection_controller.dart';

class RoleSelectionView extends GetView<RoleSelectionController> {
  const RoleSelectionView({super.key});
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
          Text("Select your role from below. You can either be a user or a service provider.",textAlign: TextAlign.center, style: textStyle.bodyMedium,),

          Spacer(),
          AppButton(titel: "Continue As User",onPress: (){
            controller.roleSelection.value = "user" ;
            debugPrint(controller.roleSelection.toString());
            Get.toNamed(Routes.SIGN_UP);
          },),
          SizedBox(height: 12.h,),
          AppButton(titel: "Continue As Service Provider",containerColor: 1,onPress: (){
            controller.roleSelection.value = "service_provider" ;
            debugPrint(controller.roleSelection.toString());
            Get.toNamed(Routes.SIGN_UP);
          },),
          SizedBox(height: 20.h,),

        ],
      ),),
    );
  }
}
