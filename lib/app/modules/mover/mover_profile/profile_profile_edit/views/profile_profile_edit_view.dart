import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../../core/const/app_colors.dart';
import '../../../../../core/widget/App_button.dart';
import '../../../../../core/widget/app_image_frame_radious_widget.dart';
import '../controllers/profile_profile_edit_controller.dart';

class ProfileProfileEditView extends GetView<ProfileProfileEditController> {
  const ProfileProfileEditView({super.key});
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
              SizedBox(height: 24.h,),
              Text("Edit Profile",style: textStyele.titleMedium,),
              SizedBox(height: 4.h,),
              Text("Edit information you provided about yourself.",style: textStyele.bodyMedium,),
              SizedBox(height: 12.h),
              TextField(
                controller: controller.nameTextEditingController,
                cursorHeight: 20,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                cursorHeight: 20,
                controller: controller.phoneTextEditingController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: controller.emailTextEditingController,
                cursorHeight: 20,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: controller.addressTextEditingController,
                cursorHeight: 20,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text("Edit Your Specialty",style: textStyele.titleMedium,),
              SizedBox(height: 24.h),
              //add
              Row(
                children: [
                  SizedBox(
                    width: 250.w,
                    child: TextField(
                      controller: controller.specilizTextController,
                      cursorHeight: 18,
                      decoration: InputDecoration(
                        hintText: "Heavy moving"
          
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w,),
                  Expanded(
                    child: AppButton(titel: "Add",onPress: (){
                      if(controller.specilizTextController.text.isEmpty){
                        return null ;
                      }
                      controller.specilized.add(controller.specilizTextController.text.trim());
                      controller.specilizTextController.clear() ;
                    },),
                  )
                ],
              ),
              Obx(() => Column(
                children: List.generate(
                  controller.specilized.length,
                      (index) {
                    var data = controller.specilized[index];

                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.onPrimaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                data,
                                style: textStyele.bodyLarge!.copyWith(
                                  color: AppColors.secoundaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 4,
                          child: InkWell(
                            onTap: () {
                              controller.specilized.removeAt(index);
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: AppColors.secoundaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  color: AppColors.primaryColor,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ))







            ],
          ),
        ),
      ),
    );
  }
}
