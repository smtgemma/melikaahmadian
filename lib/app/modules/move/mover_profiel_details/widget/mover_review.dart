import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_image_frame_radious_widget.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'package:get/get.dart';

import '../controllers/mover_profiel_details_controller.dart';
class MoverReview extends StatelessWidget {
  const MoverReview({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    final controller = Get.put(MoverProfielDetailsController());
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: AppColors.cardColor,borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Reviews",style: textStyele.titleLarge,),
              Obx(() => InkWell(onTap:(){
                controller.more();
              },child: Text(controller.isMore.value ? "See More" : "See Less",style: textStyele.titleMedium!.copyWith(color: AppColors.hardBlueColor,fontSize: 14.sp),),),)


            ],
          ),
          SizedBox(height: 12.h,),
          Obx(() {
            final itemCount =
            controller.isMore.value ? 5 : 2;

            return Column(
              children: List.generate(itemCount, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// Leading Image
                            AppImageFrameRadiousWidget(radious: 25),

                            SizedBox(width: 12.w),

                            /// Title & Subtitle
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ahmed Rahman",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyele.titleMedium,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "1 month ago",
                                    style: textStyele.bodyMedium,
                                  ),
                                ],
                              ),
                            ),

                            /// Rating
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(Assets.iconsColorStar),
                                SizedBox(width: 4.w),
                                Text(
                                  "4/5",
                                  style: textStyele.titleMedium!
                                      .copyWith(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Jonathan is professional and he maintains excellent control over matches. Highly recommended.",
                          style: textStyele.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          })

        ],
      ),

    );
  }
}
