import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../core/widget/app_back_button.dart';
import '../../../../core/widget/app_background.dart';
import '../../../../routes/app_pages.dart';
import '../../document_uplod/widget/file_box.dart';
import '../../document_uplod_page/widget/document_featur.dart';
import '../controllers/image_uplod_controller.dart';

class ImageUplodView extends GetView<ImageUplodController> {
  const ImageUplodView({super.key});
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
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(Assets.iconsVanTrack),
                      SizedBox(width: 08),
                      Text(
                        "Vehicle Photos",
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
                        "2 of 2",
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
              Text("Upload clear photos of your truck or van from different angles. Add more than 1 photo.",style: textStyele.bodyMedium,),
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
              Obx(() {
                if(controller.isImageList.isNotEmpty){
                  return AppButton(titel: "Continue",onPress: (){Get.toNamed(Routes.REVIEW_EVRYTHING);},);
                }else{
                  return AppButton(onPress: null,bodycolor: AppColors.cardColor,titel: "Continue",) ;
                }
              },),
              SizedBox(height: 24.h,),
            ],
          ),
        ),
      ),
    );
  }
}
