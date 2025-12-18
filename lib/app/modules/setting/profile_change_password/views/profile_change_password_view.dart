import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../core/widget/App_button.dart';
import '../controllers/profile_change_password_controller.dart';

class ProfileChangePasswordView
    extends GetView<ProfileChangePasswordController> {
   ProfileChangePasswordView({super.key});
   final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 24.h,),
            Text("Change Password",style: textStyele.titleMedium,),
            SizedBox(height: 04.h,),
            Text("Change current password and set a new one.",style: textStyele.bodyMedium,),
            SizedBox(height: 24.h,),
            Form(
                key: _globalKey,
                child: Column(
                  children: [
                    Obx(() =>  TextFormField(
                      onTap: (){
                        controller.oldPass();
                      },
                      controller: controller.oldPassTextEditingController,
                      obscureText: controller.isoldPassVisibility.value == false,
                      obscuringCharacter: "*",
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      cursorHeight: 16.h,
                      // style: textStyle.labelLarge!.copyWith(color: AppColors.secoundaryColor),
                      decoration: InputDecoration(hintText: "Enter new password",suffixIcon: controller.isVisibility.value == true ? Icon(Icons.visibility_outlined): Icon(Icons.visibility_off_outlined)),
                    ),),
                    SizedBox(height: 12.h,),
                    Obx(() =>  TextFormField(
                      onTap: (){
                        controller.visibility();
                      },
                      controller: controller.passTextEditingController,
                      obscureText: controller.isVisibility.value == false,
                      obscuringCharacter: "*",
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      cursorHeight: 16.h,
                     // style: textStyle.labelLarge!.copyWith(color: AppColors.secoundaryColor),
                      decoration: InputDecoration(hintText: "Enter new password",suffixIcon: controller.isVisibility.value == true ? Icon(Icons.visibility_outlined): Icon(Icons.visibility_off_outlined)),
                    ),),
                    SizedBox(height: 12.h,),
                    Obx(() =>  TextFormField(
                      onTap: (){
                        controller.confrimvisibility();
                      },
                      controller: controller.confrimePassTextEditingController,
                      obscureText: controller.isConfirmeVisibility.value == false,
                      obscuringCharacter: "*",
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      cursorHeight: 16.h,
                     // style: textStyle.labelLarge!.copyWith(color: AppColors.secoundaryColor),
                      decoration: InputDecoration(hintText: "Confirm new password",suffixIcon: controller.isConfirmeVisibility.value == true ? Icon(Icons.visibility_outlined): Icon(Icons.visibility_off_outlined)),
                    ),),
                    SizedBox(height: 24.h,),
                    AppButton(titel: "Save Password",onPress: (){
                      if(_globalKey.currentState!.validate()){


                      }

                    },)
                  ],

                )),




          ],
        ),
      ),
    );
  }



}
