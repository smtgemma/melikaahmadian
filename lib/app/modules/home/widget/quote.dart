import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/modules/home/controllers/home_controller.dart';
import 'package:melikaahmadian/app/modules/home/video_cmera/views/video_cmera_view.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'package:get/get.dart';

class Quote extends StatelessWidget {
  bool? ai;
  Quote({super.key, this.ai});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: ai == true ? AppColors.cardColor : AppColors.secoundaryColor,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: (ai == true ? Colors.black : AppColors.secoundaryColor)
                .withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: ai == true
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              Container(
                height: 54.h,
                width: 54.w,
                decoration: BoxDecoration(
                  color: ai == true
                      ? AppColors.secoundaryColor.withOpacity(0.1)
                      : AppColors.cardColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    ai == true ? Assets.iconsVideo : Assets.iconsHomeBook,
                    width: 28.w,
                    color: ai == true
                        ? AppColors.secoundaryColor
                        : AppColors.secoundaryColor,
                  ),
                ),
              ),
              if (ai == true)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.errorColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(30.w),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.errorColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    "BETA AI",
                    style: textStyele.labelSmall!.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            ai == true ? "Get AI Quote" : "Get Manual Quote",
            style: textStyele.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: ai == true
                  ? AppColors.secoundaryColor
                  : AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            ai == true
                ? "AI will generate the moving quote based on the video you post."
                : "Select the items you want to move & post your request. You will receive offers.",
            textAlign: TextAlign.center,
            style: textStyele.bodyMedium!.copyWith(
              height: 1.4,
              color: ai == true
                  ? AppColors.textSecoundaryColor.withOpacity(0.8)
                  : AppColors.primaryColor.withOpacity(0.9),
            ),
          ),
          SizedBox(height: 20.h),
          AppButton(
            titel: ai == true ? "Get AI Quote Now" : "Post A Move",
            containerColor: 1,
            bodycolor: AppColors.primaryColor,
            onPress: () async {
              if (ai == true) {
                controller.videoType.value = "ai_video";
                Get.to(VideoCmeraView(navigatorType: 'ai'));
              } else {
                controller.videoType.value = "normal_video";
                Get.toNamed(Routes.VIDEO_CMERA);
              }
            },
          ),
        ],
      ),
    );
  }
}
