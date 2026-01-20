import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/widget/app_image_frame_radious_widget.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/const/app_colors.dart';
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
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.secoundaryColor,
                ),
              );
            }
            return  SingleChildScrollView(
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
                                  radious: 50,
                                  imageLink:
                                  "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTY1LWtsaGN3ZWNtLmpwZw.jpg",
                                );
                              }

                              return AppImageFrameRadiousWidget(
                                radious: 50,
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
                                      controller.profileModel.value?.data?.fullName ?? "",
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
                                            double rating = controller.profileModel.value?.data?.averageRating ?? 4.5;

                                            // Convert to string, remove trailing .0 if whole number
                                            String displayRating = rating % 1 == 0
                                                ? rating.toInt().toString()   // 4.0 -> 4
                                                : rating.toStringAsFixed(1);  // 4.5 -> 4.5

                                            return Text(
                                              displayRating,
                                              style: textStyele.bodyMedium!.copyWith(
                                                color: AppColors.primaryColor,
                                                fontSize: 14,
                                              ),
                                            );
                                          })


                                        ],
                                      ),
                                      SizedBox(width: 08.w),
                                      Obx(() {
                                        // Get average rating safely
                                        double rating = controller.profileModel.value?.data?.averageRating ?? 0;

                                        // Convert to string, remove trailing .0 if whole number
                                        String displayRating = rating % 1 == 0
                                            ? rating.toInt().toString()   // 4.0 -> 4
                                            : rating.toStringAsFixed(1);  // 4.5 -> 4.5

                                        return Text(
                                          "$displayRating Reviews",
                                          style: textStyele.bodyMedium!.copyWith(
                                            color: AppColors.primaryColor,
                                            fontSize: 14,
                                          ),
                                        );
                                      })

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
                          String createdAt = controller.profileModel.value?.data?.createdAt.toString() ?? "";

                          DateTime date = DateTime.parse(createdAt);
                          int year = date.year;

                          print(year); // 2026

                          return ExperenceBo(
                            rating:
                            controller.profileModel.value?.data?.moves
                                .toString() ??
                                "",
                          );
                        }),
                      ),
                      SizedBox(width: 12.w),
                      Obx(() {
                        String createdAt =
                            controller.profileModel.value?.data?.createdAt
                                .toString() ??
                                "";

                        if (createdAt.isEmpty) {
                          return const SizedBox(); // prevent crash
                        }

                        DateTime joinDate = DateTime.parse(createdAt);
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
                  Obx(() => About(bio: controller.profileModel.value?.data?.bio)),
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
                    "Upload Photo For Client To See in Profiloe",
                    style: textStyele.titleLarge,
                  ),
                  SizedBox(height: 12.h),


                SizedBox(
                  height: 250.h,
                  child: Obx(
                        () => GridView.builder(
                      itemCount: controller.vehicleImages.value.length ?? 0,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        final data = controller.vehicleImages.value[index];

                        // If URL is null or empty, show placeholder
                        if (data == null || data.isEmpty) {
                          return AppImageFrameRadiousWidget(radious: 50);
                        }

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            data,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child; // image loaded

                              return Container(
                                color: Colors.grey[300],
                                child:  Center(
                                  child: CircularProgressIndicator(strokeWidth: 2,color: AppColors.secoundaryColor,),
                                ),
                              );
                            },
                            // This handles invalid URLs
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                  SizedBox(height: 12.h),


                  // SizedBox(
                  //   height: 250.h,
                  //   child: GridView.builder(
                  //
                  //     itemCount: 2,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 2,
                  //         crossAxisSpacing: 5,mainAxisSpacing: 5), itemBuilder: (context, index) {
                  //     return ClipRRect(
                  //         borderRadius: BorderRadius.circular(12),
                  //         child: Image.asset(Assets.imagesTruck)
                  //     );
                  //   },),
                  // ),
                  //mover review
                  MoverReview(),
                  SizedBox(height: 24.h),
                  AppButton(titel: "Back",onPress: (){
                    Get.back();
                  },),
                  SizedBox(height: 24.h),
                ],
              ),
            ) ;
          },),
          onRefresh: () {
            return controller.refresh();
          },
        ),
      ),
    );
  }
}
