import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../controllers/document_uplod_controller.dart';
import '../widget/file_box.dart';

class DocumentUplodView extends GetView<DocumentUplodController> {
  const DocumentUplodView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(Assets.iconsBook),
                    SizedBox(width: 08),
                    Text(
                      "Upload Documents",
                      style: textStyele.bodyMedium!.copyWith(
                        color: AppColors.secoundaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.onPrimaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.secoundaryColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "1 of 2",
                      style: textStyele.bodyMedium!.copyWith(
                        color: AppColors.secoundaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
           Obx( () =>  LinearProgressIndicator(
             value: controller.indicatorValue.value,
             color: AppColors.secoundaryColor,
             backgroundColor: AppColors.cardColor,
             minHeight: 10.h,
             borderRadius: BorderRadius.circular(10),
           ),),
            SizedBox(height: 24.h,),
            Text("Please upload your driving license, ownership proof & insurance as verification documents.",style: textStyele.bodyMedium,),
            SizedBox(height:24.h,),
            Obx(() {
              if (controller.selectedFiles.isEmpty) {
                return const SizedBox();
              }

              return Column(
                children: List.generate(
                  controller.selectedFiles.length,
                    (index) {
                      var data = controller.fileNames[index];
                      return Padding(
                        padding:  EdgeInsets.only(bottom: 12.w),
                        child: FileBox(titel: data,onPress: (){controller.removeFile(index);},),
                      );
                    },
                ),
              );
            }),
            InkWell(
              onTap: (){

                if(controller.fileNames.length == controller.maxLimit){
                  return  ;
                }
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
                    Text("Upload Document",style: textStyele.bodyMedium!.copyWith(color: AppColors.secoundaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                    SizedBox(height:4.h,),
                    Text("PDF, JPG or PNG",style: textStyele.bodyMedium),
                  ]
                ),
              ),
            ),
            SizedBox(height: 24.h,),
            Obx(() {
              if(controller.fileNames.length == controller.maxLimit){
                return AppButton(titel: "Continue",onPress: (){Get.toNamed(Routes.IMAGE_UPLOD);},);
              }else{
                return AppButton(onPress: null,bodycolor: AppColors.cardColor,titel: "Continue",) ;
              }
            },)
          ],
        ),
      ),
    );
  }
}
