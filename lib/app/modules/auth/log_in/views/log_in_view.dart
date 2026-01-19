import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/log_in_controller.dart';
import '../repository/log_in_repository.dart';

class LogInView extends GetView<LogInController> {
  LogInView({super.key});
  final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var textStyle = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              Text(
                "Log in to your Moveforce account to continue",
                style: textStyle.headlineLarge,
              ),
              SizedBox(height: 08.h),
              Text(
                "Provide information to log in.",
                style: textStyle.bodyMedium,
              ),
              SizedBox(height: 24.h),
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.emailTextEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        } else if (!GetUtils.isEmail(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      cursorHeight: 16.h,
                      style: textStyle.labelLarge!.copyWith(
                        color: AppColors.secoundaryColor,
                      ),
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    SizedBox(height: 12.h),
                    Obx(
                      () => TextFormField(
                        onTap: () {
                          controller.visibility();
                        },
                        controller: controller.passTextEditingController,
                        obscureText: controller.isVisibility.value == false,
                        obscuringCharacter: "*",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        cursorHeight: 16.h,
                        style: textStyle.labelLarge!.copyWith(
                          color: AppColors.secoundaryColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          suffixIcon: controller.isVisibility.value == true
                              ? Icon(Icons.visibility_outlined)
                              : Icon(Icons.visibility_off_outlined),
                        ),
                      ),
                    ),
                    SizedBox(height: 08.h),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.CREATE_ACCOUNT);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Forgot password?',
                          style: textStyle.bodyMedium!.copyWith(
                            color: AppColors.errorColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Obx(
                      () => AppButton(
                        titel: "Continue",
                        onPress: () {
                          if (_globalKey.currentState!.validate()) {
                            LogInRepository.login();
                          }
                        },
                        isLoding: controller.isLoading.value,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ROLE_SELECTION);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account? ",
                      style: textStyle.bodyMedium,
                    ),
                    Text(
                      " Sign Up",
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
      ),
    );
  }
}
