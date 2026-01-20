import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../core/const/app_colors.dart';
import '../../../../../core/widget/App_button.dart';
import '../../../../../core/widget/app_image_frame_radious_widget.dart';
import '../../controllers/mover_profile_controller.dart';
import '../controllers/profile_profile_edit_controller.dart';
import '../repository/profile_profile_edit_repository.dart';

class ProfileProfileEditView extends GetView<ProfileProfileEditController> {
  const ProfileProfileEditView({super.key});
  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<MoverProfileController>();
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
                ) : AppImageFrameRadiousWidget(radious: 55,imageLink: profileController.profileModel.value.data?.image,), ),
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
                controller: profileController.nameTextEditingController,
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
              // SizedBox(height: 12.h),
              // TextField(
              //   cursorHeight: 20,
              //   controller: controller.phoneTextEditingController,
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: AppColors.cardColor,
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //     disabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //   ),
              // ),
              SizedBox(height: 12.h),
              // TextField(
              //   controller: controller.emailTextEditingController,
              //   cursorHeight: 20,
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: AppColors.cardColor,
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //     disabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //   ),
              // ),
              // SizedBox(height: 12.h),
              // TextField(
              //   controller: controller.addressTextEditingController,
              //   cursorHeight: 20,
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: AppColors.cardColor,
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //     disabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //   ),
              // ),
              // SizedBox(height: 24.h),
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
                      profileController.selectedSpecialties.add(controller.specilizTextController.text) ;
                      controller.specilizTextController.clear();

                    },),
                  )
                ],
              ),
               SizedBox(height: 24.h),
               // spechileties
               Obx(() {
                 return Wrap(
                   spacing: 8,
                   runSpacing: 8,

                   children: List.generate(profileController.selectedSpecialties.length,
                         (index) {
                       return Chip(
                         backgroundColor: AppColors.secoundaryColor,
                         label: Text(profileController.selectedSpecialties[index],style: textStyele.bodyMedium!.copyWith(color: AppColors.primaryColor),),
                         deleteIcon:  Icon(Icons.close,color: AppColors.primaryColor,),
                         onDeleted: (){
                           profileController.selectedSpecialties.removeAt(index) ;
                         },
                       );
                     },
                   ),
                 );
               },),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(child: AutoSizeText("Do you want to delete the previous vehicle photo?",style: textStyele.titleMedium,maxLines: 2,)),
                  SizedBox(width: 12.w,),



                ],
              ),
              SizedBox(height: 24.h),
              Obx(() =>  AppButton(titel: "Delete",onPress: (){
                ProfileProfileEditRepository.deletVehiclePhoto() ;
              },isLoding: controller.deleteLoading.value,width: 100.w,),),
              SizedBox(height: 24.h),
              Text("Upload Photo For Client To See in Profiloe",style: textStyele.titleMedium,),
              SizedBox(height:24.h,),
              Obx(() => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: controller.selectedFiles.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: controller.isImageList[index]
                            ? Image.file(
                          controller.selectedFiles[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                            : Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(
                              Icons.picture_as_pdf,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 6,
                        right: 6,
                        child: InkWell(
                          onTap: () => controller.removeFile(index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )),
              SizedBox(height: 12.h),

              //Upload Vehicle Photo
              InkWell(
                onTap: (){
                  controller.pickDocument();
                },
                child: Container(
                  height: 169.h,
                  width: double.infinity,
                  decoration: BoxDecoration(color:AppColors.cardColor,borderRadius: BorderRadius.circular(12)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.iconsUpload),
                        SizedBox(height:8.h,),
                        Text("Upload Vehicle Photo",style: textStyele.bodyMedium!.copyWith(color: AppColors.secoundaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(height:4.h,),
                        Text("JPG or PNG",style: textStyele.bodyMedium),
                      ]
                  ),
                ),
              ),
              SizedBox(height: 24.h,),
              //button
             Obx(() =>  AppButton(titel: "Save",onPress: (){
              // ProfileProfileEditRepository.updateNameSpecialization() ;

               if(controller.selectedFiles.isEmpty){
                 ProfileProfileEditRepository.uplodvehiclePicture() ;
               }else{
                 ProfileProfileEditRepository.updateNameSpecialization() ;
                 ProfileProfileEditRepository.uplodvehiclePicture() ;
               }}


               //Get.toNamed(Routes.MOVER_NAVBAR);
             ,isLoding: controller.isupdateLoading.value,),),
              SizedBox(height: 24.h,),









            ],
          ),
        ),
      ),
    );
  }
}
