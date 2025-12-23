import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/widget/app_image_frame_radious_widget.dart';
import '../controllers/profile_edit_controller.dart';
import '../widget/edit_box.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  const ProfileEditView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(child: 
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 24.h,),
            //image
            Center(child: Stack(children:[
              Obx(() => controller.selectedImage.value != null ? CircleAvatar(
                radius: 55,
                backgroundImage: FileImage(controller.selectedImage.value!),
              ) : AppImageFrameRadiousWidget(radious: 55), ),
              Positioned(
                  bottom: 0,
                  right: -5,
                  child: GestureDetector(
                    onTap: (){
                      controller.pickImageFromGallery();
                    }, child:CircleAvatar(backgroundColor: AppColors.cardColor,child: Center(child: Icon(Icons.camera_alt_outlined),),)))
        
            ])),
            SizedBox(height: 48.h,),
            Text("Profile Information",style: textStyele.titleMedium,),
            SizedBox(height: 4.h,),
            Text("Profile information you provided. ",style: textStyele.bodyMedium,),
            SizedBox(height: 12.h,),
            Obx(() => TextField(controller: controller.nameController,
              readOnly:controller.isEdit.value ,
            ),),
            SizedBox(height: 12.h,),
            Obx(() => TextField(controller: controller.phoneController,
              readOnly:controller.isEdit.value ,
            ),),
            SizedBox(height: 12.h,),
            Obx(() => TextField(controller: controller.emailController,
              readOnly:controller.isEdit.value ,
            ),),
            SizedBox(height: 24.h,),
            Obx(() => controller.isEdit.value == false ?  EditBox() : AppButton(child: true,iconPath: Assets.iconsProfileEdit,titel: "Edit Information",onPress: (){
              controller.setEdit(false);
              debugPrint(controller.isEdit.toString());
            },) ,)
        
        
          ],
        ),
      ),),
    );
  }
}
