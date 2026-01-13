import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_image_frame_radious_widget.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'package:get/get.dart';

import '../controllers/mover_profiel_details_controller.dart';

class MoverReview extends StatelessWidget {
  MoverReview({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    final controller = Get.put(MoverProfielDetailsController());
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Reviews", style: textStyele.titleLarge),
              Obx(
                () => InkWell(
                  onTap: () {
                    controller.more();
                  },
                  child: Text(
                    controller.isMore.value ? "See More" : "See Less",
                    style: textStyele.titleMedium!.copyWith(
                      color: AppColors.hardBlueColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Obx(() {
            final itemCount = controller.isMore.value
                ? 2:controller.reviewmodel.value.data!.length ;
            return Column(
              children: List.generate(itemCount, (index) {
                final review = controller.reviewmodel.value.data?[index];
                String createdAt = review?.createdAt.toString() ?? "";

                DateTime date = DateTime.parse(createdAt);
                int year = date.year;
                final imagereviewer = review?.reviewer?.image ;

                print(year);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// Leading Image

                               (imagereviewer == null || imagereviewer.isEmpty)   ? AppImageFrameRadiousWidget(radious: 50,
                                  imageLink:
                                      "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTY1LWtsaGN3ZWNtLmpwZw.jpg",
                                ) :
                               AppImageFrameRadiousWidget(
                                radious: 50,
                                imageLink:
                                    controller.profileModel.value?.data?.image,
                              ),

                            SizedBox(width: 12.w),

                            /// Title & Subtitle
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    review?.reviewer.fullName ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyele.titleMedium,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    year == DateTime.now().year
                                        ? "Today"
                                        : year.toString(),
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
                                  "${review?.rating}/5",
                                  style: textStyele.titleMedium!.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "${review?.comment ?? ""} ",
                          textAlign: TextAlign.start,
                          style: textStyele.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}
