import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/widget/shimmer_loader.dart';

import '../../../core/widget/mover_move_video_status.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../widget/quote.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.getMoves(),
          child: AppBackground(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  //name and notification
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MoveForce",
                            style: textStyele.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secoundaryColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            "Moving made simple",
                            style: textStyele.bodySmall!.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(Routes.NOTIFICATION),
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          // padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Icon(
                                Icons.notifications_none_outlined,
                                size: 26,
                                color: AppColors.secoundaryColor,
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  height: 12.h,
                                  width: 12.w,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Quote(),
                  SizedBox(height: 16.h),
                  Quote(ai: true),
                  SizedBox(height: 24.h),
                  Text(
                    "Upcoming Moves & Updates",
                    style: textStyele.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Column(
                        children: List.generate(
                          3,
                          (index) => const MoverMoveStatusShimmer(),
                        ),
                      );
                    }

                    final data = controller.postItems;

                    if (data.isEmpty) {
                      return Center(
                        child: Text(
                          "No Post Found",
                          style: textStyele.titleMedium,
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];

                        String formattedDate = (item.createdAt ?? "")
                            .split("T")
                            .first;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: MoverMoveStatusVideo(
                            isOffer: true,
                            postId: item.id,
                            videoUrl: item.media?.isNotEmpty == true
                                ? item.media!.first.url
                                : null,
                            from: item.dropoffAddress?.address ?? "",
                            to: item.pickupAddress?.address ?? "",
                            date: formattedDate,
                            isNavigator: false,
                            titel: "Post",
                            // color: _statusBgColor(item.status),
                            //textColor: _statusTextColor(item.status),
                            isType: item.status ?? "",
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
