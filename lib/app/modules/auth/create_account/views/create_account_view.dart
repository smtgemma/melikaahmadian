import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../core/widget/app_background.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/create_account_controller.dart';

class CreateAccountView extends GetView<CreateAccountController> {
  CreateAccountView({super.key});
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
              Text("Enter your Email", style: textStyle.headlineLarge),
              SizedBox(height: 08.h),
              Text("Type your Email below.", style: textStyle.bodyMedium),
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

                    AppButton(
                      titel: "Continue",
                      onPress: () {
                        if (_globalKey.currentState!.validate()) {
                          // Get.toNamed(
                          //   Routes.VERIFICATION_CODE,
                          //   // arguments: {
                          //   //   "email":
                          //   //       controller.emailTextEditingController.text,
                          //   // },
                          // );
                          print(
                            "email${controller.emailTextEditingController.text}",
                          );
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
