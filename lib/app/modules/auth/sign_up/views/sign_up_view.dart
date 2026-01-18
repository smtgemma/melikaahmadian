import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/modules/auth/sign_up/service/google-service.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../core/widget/app_background.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyle = TextTheme.of(context);
    final authService = AuthService();
    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(height: 16.h),
            Center(child: Image.asset(Assets.imagesTruck)),
            SizedBox(height: 26.h),
            Text(
              "MOVEFORCE",
              style: textStyle.headlineLarge!.copyWith(fontSize: 32.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              "Select your role from below. You can either be a user or a service provider.",
              textAlign: TextAlign.center,
              style: textStyle.bodyMedium,
            ),
            SizedBox(height: 44.h),
            AppButton(
              titel: "Continue With Email",
              onPress: () {
                Get.toNamed(Routes.CREATE_ACCOUNT_WITH_EMAIL);
              },
            ),
            SizedBox(height: 24.h),
            AppButton(
              onPress: () {
                authService.login();
              },
              child: true,
              titel: "Continue With Google",
              iconPath: Assets.imagesGoole,
              containerColor: 1,
            ),
            SizedBox(height: 24.h),
            AppButton(
              child: true,
              titel: "Continue With Apple",
              iconPath: Assets.imagesApple,
              containerColor: 1,
            ),
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.LOG_IN);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?",
                    style: textStyle.bodyMedium,
                  ),
                  Text(
                    " Log In",
                    style: textStyle.bodyMedium!.copyWith(
                      color: AppColors.secoundaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
