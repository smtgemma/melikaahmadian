import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../core/widget/App_button.dart';
import '../controllers/profile_change_password_controller.dart';
import '../repository/profile_change_password.dart';

class ProfileChangePasswordView
    extends GetView<ProfileChangePasswordController> {
   ProfileChangePasswordView({super.key});
   final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
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
                        decoration: InputDecoration(hintText: "Old password",suffixIcon: IconButton(onPressed: (){ controller.oldPass();}, icon: controller.isoldPassVisibility.value == true ?  Icon(Icons.visibility_outlined): Icon(Icons.visibility_off_outlined))   ),
                      ),),
                      SizedBox(height: 12.h,),
                      Obx(() =>  TextFormField(
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
                        decoration: InputDecoration(hintText: "Enter new password",suffixIcon:   IconButton(onPressed: (){ controller.visibility();}, icon:controller.isVisibility.value == true ?  Icon(Icons.visibility_outlined): Icon(Icons.visibility_off_outlined))   ),
                      ),),
                      SizedBox(height: 12.h,),
                      Obx(() =>  TextFormField(

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
                        decoration: InputDecoration(hintText: "Confirm new password",suffixIcon:IconButton(onPressed: (){ controller.confrimvisibility();}, icon:controller.isConfirmeVisibility.value == true ?  Icon(Icons.visibility_outlined): Icon(Icons.visibility_off_outlined))),
                      ),),
                      SizedBox(height: 24.h,),
                    Obx(() =>   AppButton(titel: "Save Password",onPress: (){
                      if(_globalKey.currentState!.validate()){
                        if(controller.passTextEditingController.text != controller.confrimePassTextEditingController.text){
                          Get.snackbar("Error", "Passwords do not match");
                        }else{
                          ProfileChangePassword.chnagePassword() ;
                        }
                      }else{

                        //controller.changePassword();

                      }

                    },isLoding: controller.isLoading.value,),)
                    ],
          
                  )),
          
          
          
          
            ],
          ),
        ),
      ),
    );
  }



}
