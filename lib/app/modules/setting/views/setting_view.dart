import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/widget/app_image_frame_radious_widget.dart';
import 'package:melikaahmadian/app/modules/auth/log_in/controllers/log_in_controller.dart';

import '../../../../generated/assets.dart';
import '../../../core/const/app_argument_string.dart';
import '../../../core/network/shared_prepharence_helper.dart';
import '../../../routes/app_pages.dart';
import '../controllers/setting_controller.dart';
import '../repository/setting_reository.dart';
import '../widget/profile_type.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(
        child: RefreshIndicator(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 35.h),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppImageFrameRadiousWidget(radious: 50,imageLink: controller.profileModel.value.data?.image,),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              controller.profileModel.value.data?.fullName ??
                                  "Name",
                              style: textStyele.titleLarge,
                            ),
                          ),
                          SizedBox(width: 08.w),
                          Row(
                            children: [
                              Image.asset(Assets.iconsColorStar),
                              SizedBox(width: 12),
                              Obx(() {
                                final rating = controller
                                    .profileModel
                                    .value
                                    .data
                                    ?.averageRating;

                                return Text(
                                  rating != null
                                      ? rating.toStringAsFixed(1)
                                      : "0.0",
                                  style: textStyele.titleMedium,
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                      Obx(
                        () => Text(
                          controller.profileModel.value.data?.email ?? "Email",
                          style: textStyele.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                  Obx(() => ProfileType(
                    profileImage: controller.profileModel.value.data?.image,
               titel: controller.profileModel.value.data?.fullName.toString(),
               isProfile: true,
               onpress: () {
                 Get.toNamed(Routes.PROFILE_EDIT,arguments: {
                   AppArgumentString.email: controller.profileModel.value.data?.email,
                   AppArgumentString.name: controller.profileModel.value.data?.fullName,
                   AppArgumentString.phone: controller.profileModel.value.data?.phone,
                   AppArgumentString.image: controller.profileModel.value.data?.image,

                 });
               },
             ),),
                ProfileType(
                  titel: "Change Password",
                  onpress: () {
                    Get.toNamed(Routes.PROFILE_CHANGE_PASSWORD);
                  },
                ),
                ProfileType(
                  titel: "Move Cancel Request",
                  onpress: () {
                    Get.toNamed(Routes.CENCEL_REQUEST);
                  },
                  iconPath: Assets.iconsMoveCencel,
                ),
                ProfileType(
                  titel: "Terms & Condition",
                  onpress: () {
                    Get.toNamed(Routes.TERMS_CONDITION);
                  },
                  iconPath: Assets.iconsTrams,
                ),
                ProfileType(
                  titel: "Privacy Policy",
                  onpress: () {
                    Get.toNamed(Routes.PRIVACY_POLICY);
                  },
                  iconPath: Assets.iconsPrivacy,
                ),
                ProfileType(
                  titel: "Log Out",
                  onpress: () {
                    SharedPrefHelper.clear();
                    Get.delete<LogInController>();
                    showCustomDialog(context);
                  },
                  iconPath: Assets.iconsLogout,
                  textcolor: AppColors.errorColor,
                ),
                ProfileType(
                  titel: "Temporary Switch Mover",
                  onpress: () {
                    {
                      Get.toNamed(Routes.MOVER_NAVBAR);
                    }
                  },
                  iconPath: Assets.iconsLogout,
                  textcolor: AppColors.errorColor,
                ),
              ],
            ),
          ),
          onRefresh: () {
            return controller.getProfile();
          },
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: EdgeInsets.all(16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Log Out", style: Theme.of(context).textTheme!.titleLarge),
              SizedBox(height: 04.h),
              Text(
                "Are you sure you want to log out from your account?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme!.bodyMedium,
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      titel: "No",
                      borderColor: AppColors.secoundaryColor,
                      bodycolor: AppColors.primaryColor,
                      containerColor: 1,
                      onPress: () {
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(width: 08.w),
                  Expanded(
                    child: AppButton(
                      titel: "Yes",
                      bodycolor: AppColors.errorColor,
                      containerColor: 0,
                      onPress: () {
                        Get.toNamed(Routes.LOG_IN);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
