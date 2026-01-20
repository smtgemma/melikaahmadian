import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../core/const/app_argument_string.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../core/widget/app_back_button.dart';
import '../../../../core/widget/app_background.dart';
import '../../../../routes/app_pages.dart';
import '../../../role_selection/controllers/role_selection_controller.dart';
import '../controllers/set_new_password_controller.dart';
import '../repository/sign_up_repository.dart';

class SetNewPasswordView extends GetView<SetNewPasswordController> {
  SetNewPasswordView({super.key});
  final _globalKey = GlobalKey<FormState>();
  final roleSelectionController = Get.put(RoleSelectionController());
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    controller.email = args?["email"];
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
              Text("Set your new password", style: textStyle.headlineLarge),
              SizedBox(height: 08.h),
              Text(
                "Type your new password below.",
                style: textStyle.bodyMedium,
              ),
              SizedBox(height: 24.h),
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    Obx(
                      () => TextFormField(
                        onTap: () {

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
                          hintText: "Enter new password",
                          suffixIcon: controller.isVisibility.value == true
                              ?  IconButton(onPressed: (){ controller.visibility();}, icon: Icon(Icons.visibility_outlined))
                              :  IconButton(onPressed: (){ controller.visibility();}, icon: Icon(Icons.visibility_off_outlined)),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(
                      () => TextFormField(
                        onTap: () {

                        },
                        controller:
                            controller.confrimePassTextEditingController,
                        obscureText:
                            controller.isConfirmeVisibility.value == false,
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
                          hintText: "Confirm new password",
                          suffixIcon:
                              controller.isConfirmeVisibility.value == true
                              ? IconButton(onPressed: (){ controller.confrimvisibility();}, icon: Icon(Icons.visibility_outlined))
                              : IconButton(onPressed: (){ controller.confrimvisibility();}, icon: Icon(Icons.visibility_off_outlined)),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Obx(
                      () => AppButton(
                        titel: "Save Password",
                        onPress: () {
                          if (_globalKey.currentState!.validate()) {
                            if (controller.passTextEditingController.text == controller.confrimePassTextEditingController.text)
                            {
                              if(controller.navigatorType == AppArgumentString.forgetPassword){


                                SignUpRepository.changePassword();
                                return ;
                              }else{
                               SignUpRepository.signIn();
                              }

                            } else {
                              Get.snackbar("Error", "Password not match");
                            }
                          }
                        },
                        isLoding: controller.isLoading.value,
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
