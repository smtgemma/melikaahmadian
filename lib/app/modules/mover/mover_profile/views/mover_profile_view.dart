import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/network/shared_prepharence_helper.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../core/widget/app_background.dart';
import '../../../../core/widget/app_image_frame_radious_widget.dart';
import '../../../../routes/app_pages.dart';
import '../../../setting/widget/profile_type.dart';
import '../controllers/mover_profile_controller.dart';

class MoverProfileView extends GetView<MoverProfileController> {
  const MoverProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return RefreshIndicator(child:  Scaffold(
      body:  Obx(() {
        if(controller.isLoading.value){
          return AppBackground(child: Center(child: CircularProgressIndicator(color: AppColors.secoundaryColor,)));
        }else{
          return AppBackground(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 35.h,),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() {
                          final data =
                              controller.profileModel.value.data?.image;
                          if (data == null || data.isEmpty) {
                            return AppImageFrameRadiousWidget(
                              radious: 50,
                              imageLink:
                              "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTY1LWtsaGN3ZWNtLmpwZw.jpg",
                            );
                          }

                          return AppImageFrameRadiousWidget(
                            radious: 50,
                            imageLink:
                            controller.profileModel.value.data?.image,
                          );
                        }),
                        SizedBox(height: 12.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() =>   Text(controller.profileModel.value.data?.fullName ?? "",style: textStyele.titleLarge,),),
                            SizedBox(width: 08.w,),
                            Row(
                              children: [
                                Image.asset(Assets.iconsColorStar),
                                SizedBox(width: 12,),
                                Obx(() =>  Text(controller.profileModel.value.data?.averageRating?.toStringAsFixed(1).toString() ??"0.0",style: textStyele.titleMedium,),)


                              ],
                            )
                          ],
                        ),
                        Obx(() => Text( controller.profileModel.value.data?.email ?? "",style: textStyele.bodyMedium,),)

                      ],
                    ),),
                  SizedBox(height: 24.h,),
                  Obx(() =>  ProfileType( titel:controller.profileModel.value.data?.fullName ?? "" ,
                      profileImage:controller.profileModel.value.data?.image ??"https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTY1LWtsaGN3ZWNtLmpwZw.jpg",
                      isProfile: true,onpress: (){Get.toNamed(Routes.PROFILE_MY_PROFILE);}),),
                  ProfileType(titel: "Change Password",onpress: (){Get.toNamed(Routes.PROFILE_CHANGE_PASSWORD);},),
                  ProfileType(titel: "My Earning",onpress: (){Get.toNamed(Routes.MY_ERANING);},iconPath: Assets.iconsRoudedDolar),
                  ProfileType(titel: "Terms & Condition",onpress: (){Get.toNamed(Routes.TERMS_CONDITION);},iconPath: Assets.iconsTrams,),
                  ProfileType(titel: "Privacy Policy",onpress: (){Get.toNamed(Routes.PRIVACY_POLICY);},iconPath: Assets.iconsPrivacy,),
                  ProfileType(titel: "Log Out",onpress: (){
                    showCustomDialog(context);
                  },iconPath: Assets.iconsLogout,textcolor: AppColors.errorColor,),
                  ProfileType(titel: "Temporary Switch User",onpress: (){
                    {Get.toNamed(Routes.NAVBAR);}
                  },iconPath: Assets.iconsLogout,textcolor: AppColors.errorColor,),

                ],
              ),
            ),
          ) ;
        }
      },),
    ), onRefresh: (){
      controller.getProfile();
      return Future.delayed(const Duration(seconds: 1));
    });
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
            height: 208.h,
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
                      SharedPrefHelper.clear();
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
