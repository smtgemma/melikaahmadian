import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/specialty_controller.dart';

class SpecialtyView extends GetView<SpecialtyController> {
  const SpecialtyView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBackButton(),
                SizedBox(height: 24.h),
                Text("List Your Specialty", style: textStyele.headlineLarge),
                SizedBox(height: 08.h),
                Text(
                  "Write down in which field you are most capable and and then click add.",
                  style: textStyele.bodyMedium,
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    SizedBox(
                      width: 250.w,
                      child: TextField(
                        controller: controller.specilizTextController,
                        cursorHeight: 18,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: AppButton(
                        titel: "Add",
                        hight: 55,
                        onPress: () {
                          if (controller.specilizTextController.text.isEmpty) {
                            return null;
                          }
                          controller.specilized.add(
                            controller.specilizTextController.text.trim(),
                          );
                          controller.specilizTextController.clear();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              flex: 3,
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.specilized.value.length,
                  itemBuilder: (context, index) {
                    var data = controller.specilized.value[index];
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.onPrimaryColor,
                              borderRadius: BorderRadius.circular(08),
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
                              debugPrint("fwefwe");
                              controller.specilized.remove(data);
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
                                  weight: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Obx(() =>(controller.specilized.isEmpty || controller.specilized == null) ?
              AppButton(onPress: null,bodycolor: AppColors.cardColor,titel: "Continue",) :
              AppButton(
                titel: "Continue",
                hight: 50.h,
                onPress: () {
                  Get.toNamed(Routes.DOCUMENT_UPLOD_PAGE,arguments: {
                    AppArgument.bio : controller.bio,
                    AppArgument.specializ : controller.specilized
                  });
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
