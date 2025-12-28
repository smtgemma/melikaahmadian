import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../core/widget/App_button.dart';
import '../../../../routes/app_pages.dart';
import '../../document_uplod/controllers/document_uplod_controller.dart';
import '../../document_uplod/widget/file_box.dart';
import '../../image_uplod/controllers/image_uplod_controller.dart';
import '../controllers/review_evrything_controller.dart';

class ReviewEvrythingView extends GetView<ReviewEvrythingController> {
   ReviewEvrythingView({super.key});
  final documentController = Get.find<DocumentUplodController>();
  final imageController = Get.find<ImageUplodController>();
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 24.h,),
            Text("Review Application",style: textStyele.headlineLarge,),
            SizedBox(height: 8.h,),
            Text("Your application will be reviewed by our admin team. You'll receive a notification once approved.",style: textStyele.bodyMedium,),
            SizedBox(height: 24.h,),
            Text("Uploaded Document (${documentController.fileNames.length})",style: textStyele.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
            SizedBox(height: 24.h,),
            Obx(() {
              if (documentController.selectedFiles.isEmpty) {
                return const SizedBox();
              }
        
              return Column(
                children: List.generate(
                  documentController.selectedFiles.length,
                      (index) {
                    var data = documentController.fileNames[index];
                    return Padding(
                      padding:  EdgeInsets.only(bottom: 12.w),
                      child: FileBox(titel: data,onPress: (){documentController.removeFile(index);},isClosed: true,),
                    );
        
                  },
                ),
              );
            }),
            SizedBox(height: 24.h,),
            Text("Vehicle Photos (${imageController.fileNames.length})",style: textStyele.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
            SizedBox(height: 24.h,),
            Obx(() => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: imageController.selectedFiles.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: imageController.isImageList[index]
                          ? Image.file(
                        imageController.selectedFiles[index],
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

                  ],
                );
              },
            )),
            SizedBox(height: 24.h,),
            AppButton(titel: "Submit Application",onPress: (){Get.toNamed(Routes.APPLICATION_SUBMIT,arguments: {
              "null" : "null",
            });},),
            SizedBox(height: 24.h,)
        
        
          ],
        ),
      ),),
    );
  }
}
