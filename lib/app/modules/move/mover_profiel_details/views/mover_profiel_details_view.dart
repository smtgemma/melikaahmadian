import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/widget/app_image_frame_radious_widget.dart';
import 'package:melikaahmadian/app/core/widget/shimmer_loader.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/shimmer_loader.dart';
import '../../../auth/image_uplod/controllers/image_uplod_controller.dart';
import '../widget/about.dart';
import '../widget/experence_box.dart';
import '../controllers/mover_profiel_details_controller.dart';
import '../widget/mover_review.dart';
import '../widget/specialties.dart';

class MoverProfielDetailsView extends GetView<MoverProfielDetailsController> {
  String? imageLink;
  String? videoLink;
  String? name;
  String? starRation;
  String? reviewRating;
  MoverProfielDetailsView({
    super.key,
    this.imageLink,
    this.videoLink,
    this.name,
    this.starRation,
    this.reviewRating,
  });
  @override
  Widget build(BuildContext context) {
    // String? id ;
    // final Map<String, dynamic> argu = Get.arguments ?? {};
    // controller.providerid = argu[AppArgumentString.providrId] ?? '';

    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(
        child: RefreshIndicator(
          child: Obx(() {
            if (controller.profileLoading.value) {
              return const MoverDetailsShimmer();
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBackButton(),
                  SizedBox(height: 24),
                  //name and rating
                  Stack(
                    children: [
                      Container(
                        //  height: 150.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.secoundaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 41.h),
                            Obx(() {
                              final data =
                                  controller.profileModel.value?.data?.image;
                              if (data == null || data.isEmpty) {
                                return AppImageFrameRadiousWidget(
                                  radious: 35,
                                  imageLink:
                                      "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTY1LWtsaGN3ZWNtLmpwZw.jpg",
                                );
                              }

                              return AppImageFrameRadiousWidget(
                                radious: 35,
                                imageLink:
                                    controller.profileModel.value?.data?.image,
                              );
                            }),

                            SizedBox(height: 08.h),
                            Center(
                              child: Column(
                                children: [
                                  Obx(
                                    () => Text(
                                      controller
                                              .profileModel
                                              .value
                                              ?.data
                                              ?.fullName ??
                                          "",
                                      style: textStyele.titleLarge!.copyWith(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(Assets.iconsColorStar),
                                          SizedBox(width: 04),
                                          Obx(() {
                                            // Get average rating safely, fallback to 4.5 if null
                                            double rating =
                                                controller
                                                    .profileModel
                                                    .value
                                                    ?.data
                                                    ?.averageRating ??
                                                4.5;

                                            // Convert to string, remove trailing .0 if whole number
                                            String displayRating =
                                                rating % 1 == 0
                                                ? rating
                                                      .toInt()
                                                      .toString() // 4.0 -> 4
                                                : rating.toStringAsFixed(
                                                    1,
                                                  ); // 4.5 -> 4.5

                                            return Text(
                                              displayRating,
                                              style: textStyele.bodyMedium!
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontSize: 14,
                                                  ),
                                            );
                                          }),
                                        ],
                                      ),
                                      SizedBox(width: 08.w),
                                      Obx(() {
                                        // Get average rating safely
                                        double rating =
                                            controller
                                                .profileModel
                                                .value
                                                ?.data
                                                ?.averageRating ??
                                            0;

                                        // Convert to string, remove trailing .0 if whole number
                                        String displayRating = rating % 1 == 0
                                            ? rating
                                                  .toInt()
                                                  .toString() // 4.0 -> 4
                                            : rating.toStringAsFixed(
                                                1,
                                              ); // 4.5 -> 4.5

                                        return Text(
                                          "$displayRating Reviews",
                                          style: textStyele.bodyMedium!
                                              .copyWith(
                                                color: AppColors.primaryColor,
                                                fontSize: 14,
                                              ),
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 41.h),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -40,
                        left: -40,
                        child: Container(
                          height: 123.h,
                          width: 123.w,
                          decoration: BoxDecoration(
                            color: AppColors.shadoColor.withAlpha(10),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -60,
                        right: -60,
                        child: Container(
                          height: 123.h,
                          width: 123.w,
                          decoration: BoxDecoration(
                            color: AppColors.shadoColor.withAlpha(10),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 41),
                  // move and experice
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          final data = controller.profileModel.value?.data;
                          String createdAt = data?.createdAt?.toString() ?? "";

                          DateTime? date = DateTime.tryParse(createdAt);

                          return ExperenceBo(
                            rating: data?.moves?.toString() ?? "0",
                          );
                        }),
                      ),
                      SizedBox(width: 12.w),
                      Obx(() {
                        final data = controller.profileModel.value?.data;
                        String createdAt = data?.createdAt?.toString() ?? "";

                        DateTime? joinDate = DateTime.tryParse(createdAt);
                        if (joinDate == null) {
                          return const SizedBox(); // prevent crash
                        }
                        DateTime now = DateTime.now();

                        int years = now.year - joinDate.year;

                        // Adjust if anniversary not passed yet this year
                        if (now.month < joinDate.month ||
                            (now.month == joinDate.month &&
                                now.day < joinDate.day)) {
                          years--;
                        }

                        if (years < 0) years = 0;

                        return Expanded(
                          child: ExperenceBo(
                            iconsPath: Assets.iconsBag,
                            color: AppColors.greenColor.withAlpha(10),
                            title: "Years",
                            rating: "$years+",
                            isbag: true,
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  //About
                  Obx(
                    () => About(bio: controller.profileModel.value?.data?.bio),
                  ),
                  SizedBox(height: 24.h),
                  Obx(
                    () => Specialties(
                      specialties:
                          controller.profileModel.value?.data?.specialization ??
                          [],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Upload Photo For Client To See in Profile",
                    style: textStyele.titleLarge,
                  ),
                  SizedBox(height: 12.h),

                  Obx(() {
                    if (controller.profileLoading.value) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.2,
                            ),
                        itemBuilder: (context, index) =>
                            const ShimmerWidget.rounded(height: 100),
                      );
                    }

                    if (controller.vehicleImages.isEmpty) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey[400],
                              size: 48,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "No images uploaded yet",
                              style: textStyele.bodyMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    final displayImages = controller.vehicleImages;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: displayImages.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.2,
                          ),
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: displayImages[index],
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const ShimmerWidget.rounded(height: 100),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.broken_image_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  SizedBox(height: 12.h),

                  //mover review
                  MoverReview(),
                  SizedBox(height: 24.h),
                  AppButton(
                    titel: "Back",
                    onPress: () {
                      Get.back();
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          }),
          onRefresh: () {
            return controller.refresh();
          },
        ),
      ),
    );
  }
}
