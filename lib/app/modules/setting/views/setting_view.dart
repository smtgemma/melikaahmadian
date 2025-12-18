import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/widget/app_image_frame_radious_widget.dart';

import '../../../../generated/assets.dart';
import '../../../routes/app_pages.dart';
import '../controllers/setting_controller.dart';
import '../widget/profile_type.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
     body: AppBackground(
       child: SingleChildScrollView(
         child: Column(
           children: [
             SizedBox(height: 35.h,),
             Center(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   AppImageFrameRadiousWidget(radious: 50,),
                   SizedBox(height: 12.h,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text("Mike James",style: textStyele.titleLarge,),
                       SizedBox(width: 08.w,),
                       Row(
                         children: [
                           Image.asset(Assets.iconsColorStar),
                           SizedBox(width: 12,),
                           Text("4.5",style: textStyele.titleMedium,)
         
         
                         ],
                       )
                     ],
                   ),
                   Text("mikejames@gmail.com",style: textStyele.bodyMedium,)
         
                 ],
               ),),
             SizedBox(height: 24.h,),
             ProfileType(isProfile: true,onpress: (){Get.toNamed(Routes.PROFILE_EDIT);}),
             ProfileType(titel: "Change Password",onpress: (){Get.toNamed(Routes.PROFILE_CHANGE_PASSWORD);},),
             ProfileType(titel: "Move Cancel Request",onpress: (){},iconPath: Assets.iconsMoveCencel,),
             ProfileType(titel: "Terms & Condition",onpress: (){},iconPath: Assets.iconsTrams,),
             ProfileType(titel: "Privacy Policy",onpress: (){},iconPath: Assets.iconsPrivacy,),
             ProfileType(titel: "Log Out",onpress: (){
               showCustomDialog(context);
             },iconPath: Assets.iconsLogout,textcolor: AppColors.errorColor,),
         
           ],
         ),
       ),
     ),
    );
  }
  void showCustomDialog(BuildContext context) {
    var textStyele = TextTheme.of(context);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 172.h,
            width: double.infinity,
            padding:  EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Log Out",style: textStyele!.titleLarge,),
                SizedBox(height: 04.h),
                Text("Are you sure you want to log out from your account?",textAlign: TextAlign.center,style: textStyele!.bodyMedium,),
                 SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: AppButton(titel: "No",borderColor: AppColors.secoundaryColor,bodycolor: AppColors.primaryColor,containerColor: 1,onPress: (){
                      Get.back();
                    },)),
                    SizedBox(width: 08.w,),
                    Expanded(child: AppButton(titel: "Yes",bodycolor: AppColors.errorColor,containerColor: 0,onPress: (){
                      Get.toNamed(Routes.LOG_IN);
                    },)),

                  ],
                )


              ],
            ),
          ),
        );
      },
    );
  }
}
