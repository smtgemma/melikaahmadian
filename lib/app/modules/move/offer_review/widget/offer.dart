import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_image_frame_radious_widget.dart';
import 'package:melikaahmadian/app/core/widget/move_video.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/app/core/widget/shimmer_loader.dart';

import '../../../../core/network/shared_prepharence_helper.dart';
import '../../mover_profiel_details/controllers/mover_profiel_details_controller.dart';
import '../../mover_profiel_details/views/mover_profiel_details_view.dart';
import '../controllers/offer_review_controller.dart';

class Offer extends StatelessWidget {
  String? imageLink;
  String? videoLink;
  String? name;
  String? starRation;
  String? reviewRating;

  Offer({
    super.key,
    this.imageLink,
    this.videoLink,
    this.name,
    this.starRation,
    this.reviewRating,
  });

  @override
  Widget build(BuildContext context) {
    print("=====================Showing Offer view");

    final controller = Get.find<OfferReviewController>();
    var textStyele = TextTheme.of(context);
    //return Text("data") ;

    return Obx(() {
      var data = controller.offerModel.value.data;
      if (controller.offerLoading.value) {
        return const ShimmerList(shimmerItem: OfferShimmer());
      } else if (data == null || data.isEmpty) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 100.h),
            Center(child: Text("No Offer", style: textStyele.bodyLarge)),
          ],
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.offerModel.value.data?.length ?? 0,
        itemBuilder: (context, index) {
          final data = controller.offerModel.value.data?[index];
          return Container(
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.w),
                  ),
                  child: SizedBox(
                    height: 180.h,
                    width: double.infinity,
                    child: MoveVideo(videoPath: data?.postMedia?[0].url ?? ""),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppImageFrameRadiousWidget(
                            radious: 24.w,
                            imageLink: data?.provider?.image,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data?.provider?.fullName ?? "Unknown Mover",
                                  style: textStyele.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.secoundaryColor,
                                      size: 18,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      data?.provider?.averageRating
                                              ?.toStringAsFixed(1) ??
                                          "0.0",
                                      style: textStyele.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secoundaryColor,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "(${data?.provider?.totalReview ?? 0} Reviews)",
                                      style: textStyele.bodySmall?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      if (data?.provider?.specialization != null &&
                          data!.provider!.specialization!.isNotEmpty) ...[
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: data.provider!.specialization!.map((spec) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.secoundaryColor.withOpacity(
                                  0.05,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.secoundaryColor.withOpacity(
                                    0.2,
                                  ),
                                ),
                              ),
                              child: Text(
                                spec,
                                style: textStyele.bodySmall?.copyWith(
                                  color: AppColors.secoundaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20.h),
                      ],

                      // Offer price section (unchanged)
                      Stack(
                        children: [
                          Container(
                            height: 94.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.secoundaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Offered Price\n\$${data?.offerPrice ?? "0"}",
                                  textAlign: TextAlign.center,
                                  style: textStyele.titleLarge!.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -20,
                            left: -20,
                            child: Container(
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                color: AppColors.shadoColor.withAlpha(10),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -25,
                            right: -25,
                            child: Container(
                              height: 66.h,
                              width: 66.w,
                              decoration: BoxDecoration(
                                color: AppColors.shadoColor.withAlpha(10),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      Obx(
                        () => controller.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : AppButton(
                                titel: "Accept Offer",
                                onPress: () async {
                                  await controller.acceptOffer(data?.id ?? '');
                                  Get.toNamed(
                                    Routes.PAYMENT_DETAILS,
                                    arguments: {'ProviderId': data?.id ?? ""},
                                  );
                                },
                              ),
                      ),

                      SizedBox(height: 12.h),

                      AppButton(
                        containerColor: 1,
                        titel: "View Profile",
                        bodycolor: Colors.white,
                        borderColor: AppColors.secoundaryColor,
                        onPress: () {
                          SharedPrefHelper.setString(
                            SharedPrefHelper.postMoverId,
                            data?.providerId ?? "",
                          );
                          Get.put(MoverProfielDetailsController());
                          Get.to(
                            () => MoverProfielDetailsView(),
                            arguments: {
                              AppArgumentString.providrId: data?.providerId ?? "",
                            },
                          );
                        },
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
