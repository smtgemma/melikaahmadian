import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../core/widget/app_back_button.dart';
import '../../../../core/widget/app_background.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/create_account_with_email_controller.dart';
class CreateAccountWithEmailView
    extends GetView<CreateAccountWithEmailController> {
  CreateAccountWithEmailView({super.key});
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
              AppBackButton(),
              SizedBox(height: 100.h),
              Text(
                "Create an account to continue ",
                style: textStyle.headlineLarge,
              ),
              SizedBox(height: 08.h),
              Text(
                "Provide necessary information to sign up.",
                style: textStyle.bodyMedium,
              ),
              SizedBox(height: 24.h),
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.nameTextEdittingController,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Name is required";
                        return null;
                      },
                      cursorHeight: 16.h,
                      style: textStyle.labelLarge!
                          .copyWith(color: AppColors.secoundaryColor),
                      decoration: const InputDecoration(hintText: "Full name"),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.secoundaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CountryCodePicker(
                            onChanged: (country) {
                              controller.selectedCountryCode.value =
                                  country.dialCode ?? '+1';
                            },
                            initialSelection: 'US',
                            favorite: const ['+1', 'US', '+880', 'BD'],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: controller.phoneTextEdittingController,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return "Phone is required";
                              return null;
                            },
                            cursorHeight: 16.h,
                            style: textStyle.labelLarge!
                                .copyWith(color: AppColors.secoundaryColor),
                            decoration: const InputDecoration(hintText: "Phone"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    TextFormField(
                      controller: controller.emailTextEdittingController,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Email is required";
                        else if (!GetUtils.isEmail(value))
                          return "Enter a valid email";
                        return null;
                      },
                      cursorHeight: 16.h,
                      style: textStyle.labelLarge!
                          .copyWith(color: AppColors.secoundaryColor),
                      decoration: const InputDecoration(hintText: "Email"),
                    ),
                    SizedBox(height: 16.h),

                    // Terms and Conditions Checkbox
                    Obx(
                          () => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24.h,
                            width: 24.w,
                            child: Checkbox(
                              value: controller.isTermsAccepted.value,
                              onChanged: (value) {
                                controller.toggleTerms();
                              },
                              activeColor: AppColors.secoundaryColor,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.toggleTerms();
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: "I accept the ",
                                  style: textStyle.bodyMedium,
                                  children: [
                                    TextSpan(
                                      text: "Terms and Conditions",
                                      style: textStyle.bodyMedium!.copyWith(
                                        color: AppColors.secoundaryColor,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed(Routes.TERMS_CONDITION);
                                        },
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: textStyle.bodyMedium,
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: textStyle.bodyMedium!.copyWith(
                                        color: AppColors.secoundaryColor,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed(Routes.PRIVACY_POLICY);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    AppButton(
                      titel: "Continue",
                      onPress: () {
                        if (_globalKey.currentState!.validate()) {
                          // Check if terms are accepted
                          if (!controller.isTermsAccepted.value) {
                            Get.snackbar(
                              "Terms Required",
                              "Please accept the terms and conditions to continue",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppColors.errorColor,
                              colorText: Colors.white,
                            );
                            return;
                          }

                          Get.toNamed(Routes.SET_NEW_PASSWORD, arguments: {
                            "email": controller.emailTextEdittingController.text,
                          });
                        }
                      },
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