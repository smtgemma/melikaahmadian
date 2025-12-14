import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../../core/const/app_colors.dart';
import '../controllers/video_cmera_controller.dart';

class VideoCmeraView extends GetView<VideoCmeraController> {
  const VideoCmeraView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: AppBackButton(),
          ),
          SizedBox(height: 20.h,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: AppColors.secoundaryColor),
            ),
          ),
          Container(
            height: 123.h,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.primaryColor,),
            child: InkWell(
              onTap: (){
                Get.toNamed(Routes.REVIEW_VIDEO);
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(6),
                  height: 75.h,
                  width: 75.w,
                  decoration: BoxDecoration( shape: BoxShape.circle ,border: Border.all(color: AppColors.textSecoundaryColor,width: 2) ),
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.errorColor,shape: BoxShape.circle ,),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
