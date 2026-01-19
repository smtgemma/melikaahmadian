import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/modules/home/add_details/views/add_details_view.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../../../core/widget/app_back_button.dart';
import '../../../../core/widget/move_video.dart';
import '../controllers/review_video_controller.dart';

class ReviewVideoView extends GetView<ReviewVideoController> {
  String? videoPath;
  ReviewVideoView({super.key, this.videoPath});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 4.h),
            Text("Review The Video", style: textStyele.titleLarge),
            SizedBox(height: 4.h),
            Text(
              "Make sure all items are clearly visible",
              style: textStyele.bodyMedium,
            ),
            SizedBox(height: 12.h),
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: MoveVideo(videoPath: videoPath, isAsset: true),
            ),
            SizedBox(height: 24.h),
            AppButton(

              child: true,
              titel: "Use this Video",
              iconPath: Assets.iconsTik,
              onPress: () {
              //  Get.toNamed(Routes.ADD_DETAILS, arguments: {'video':  videoPath});
                Get.to(AddDetailsView(videoPath: videoPath,));
              },
            ),
            SizedBox(height: 12.h),
            AppButton(
              child: true,
              titel: "Retake Video",
              iconPath: Assets.iconsReload,
              containerColor: 1,
              onPress: (){
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
