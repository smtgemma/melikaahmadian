import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/widget/move_video.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../controllers/add_details_controller.dart';

class AddDetailsView extends GetView<AddDetailsController> {
  String? videoPath;
  AddDetailsView({super.key,this.videoPath});

  @override
  Widget build(BuildContext context) {
    final args=Get.arguments;
    videoPath =   args['video'];


    var textStyle = Theme.of(context).textTheme;

    debugPrint(videoPath);

    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 16.h),

              // Pickup & Drop-off
              Text("Pickup & Drop-off", style: textStyle.titleLarge),
              SizedBox(height: 4.h),
              Text("Where should we move your items?", style: textStyle.bodyMedium),
              SizedBox(height: 12.h),

              // Video preview
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12.w)
                ),
                child: MoveVideo(videoPath:videoPath , isasset: true,),
              ),

              SizedBox(height: 24.h),
              Text("Address Details", style: textStyle.titleLarge),
              SizedBox(height: 144.h),
              TextField(
                controller: controller.dataEditingController,
                readOnly: true,
                onTap: () => controller.selectDate(context),
                decoration: InputDecoration(
                  hintText: "Enter pickup address",
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                ),
              ),


              // Time Details
              Text("Time Details", style: textStyle.titleLarge),
              SizedBox(height: 12.h),
              TextField(
                controller: controller.dataEditingController,
                readOnly: true,
                onTap: () => controller.selectDate(context),
                decoration: InputDecoration(
                  hintText: "Select date",
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: controller.timeEditingController,
                readOnly: true,
                onTap: () => controller.timeSelectDate(context),
                decoration: InputDecoration(
                  hintText: "Select time",
                  prefixIcon: Icon(Icons.access_time_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                ),
              ),
              SizedBox(height: 24.h),


              Text("House Type Selection", style: textStyle.titleLarge),
              Obx(
                    () => SizedBox(
                  height: 280.h,
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 3 / 2,
                    children: List.generate(controller.houseType.length, (index) {
                      var data = controller.houseType[index];
                      bool isSelected = controller.selectedHouseType.value == index;
                      return InkWell(
                        onTap: () {
                          controller.selectedHouseType.value = index;
                          controller.selectedDateText.value = data.titel.toString();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.secoundaryColor : AppColors.onPrimaryColor,
                            borderRadius: BorderRadius.circular(12.w),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  data.iconPath.toString(),
                                  color: isSelected ? AppColors.primaryColor : AppColors.secoundaryColor,
                                  height: 40.h,
                                  width: 40.w,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  data.titel.toString(),
                                  style: textStyle.bodyMedium!.copyWith(
                                    color: isSelected ? AppColors.primaryColor : AppColors.secoundaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              SizedBox(height: 24.h),
              AppButton(
                titel: 'Select Your Items',
                onPress: () {
                  Get.toNamed(Routes.CUSTOM_FURNITURE);
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
