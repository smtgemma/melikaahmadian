import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/modules/notification/controllers/notification_controller.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/app_background.dart';
import '../../../../core/widget/mover_move_video_status.dart';
import '../controllers/mover_home_controller.dart';
import '../widget/stat_of_day_poseted_move.dart';

class MoverHomeView extends GetView<MoverHomeController> {
  const MoverHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextTheme.of(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          /// Force refresh and clear cache
          await controller.getMoves(forceRefresh: true);
        },
        color: AppColors.secoundaryColor,
        backgroundColor: Colors.white,
        strokeWidth: 2.5,
        child: AppBackground(
          child: CustomScrollView(
            slivers: [
              /// Header Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),

                      /// Name and Notification
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "MoveForce",
                            style: textStyle.titleMedium!.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.NOTIFICATION);
                            },
                            child: Stack(
                              children: [
                                Icon(
                                  Icons.notifications_none_outlined,
                                  size: 28,
                                  color: AppColors.secoundaryColor,
                                ),

                                /// Dynamic Badge
                                Obx(() {
                                  final notificationController =
                                      Get.find<NotificationController>();
                                  if (notificationController
                                          .unreadCount
                                          .value ==
                                      0) {
                                    return const SizedBox.shrink();
                                  }

                                  return Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      height: 18.h,
                                      width: 18.w,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.red.withOpacity(0.4),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          notificationController
                                                      .unreadCount
                                                      .value >
                                                  9
                                              ? '9+'
                                              : '${notificationController.unreadCount.value}',
                                          style: textStyle.labelSmall!.copyWith(
                                            color: Colors.white,
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      /// Stats Card
                      StatOfDayPosetedMove(),
                      SizedBox(height: 24.h),

                      /// Section Title
                      Text(
                        "Upcoming Moves & Updates",
                        style: textStyle.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),

              /// Moves List Section
              Obx(() {
                if (controller.isLoading.value) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.secoundaryColor,
                            strokeWidth: 2.5,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "Loading moves...",
                            style: textStyle.bodyMedium?.copyWith(
                              color: AppColors.secoundaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final data = controller.postItems;

                if (data.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_shipping_outlined,
                            size: 48,
                            color: AppColors.secoundaryColor.withOpacity(0.5),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "No Moves Found",
                            style: textStyle.titleMedium!.copyWith(
                              color: AppColors.secoundaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Check back soon for new opportunities",
                            style: textStyle.bodySmall?.copyWith(
                              color: AppColors.secoundaryColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                /// List of Moves
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = data[index];
                      String formattedDate = (item.createdAt ?? "")
                          .split("T")
                          .first;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: MoverMoveStatusVideo(
                          isOffer: true,
                          postId: item.id,
                          videoUrl: item.media?.isNotEmpty == true
                              ? item.media!.first.url
                              : null,
                          from: item.dropoffAddress?.address ?? "",
                          to: item.pickupAddress?.address ?? "",
                          date: formattedDate,
                          isNavigator: true,
                          titel: "Offer",
                          isType: item.status ?? "",

                          /// Optional: Add price if available
                          price: item.offerPrice?.toString() ?? "0",
                        ),
                      );
                    }, childCount: data.length),
                  ),
                );
              }),

              /// Bottom Padding
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            ],
          ),
        ),
      ),
    );
  }
}
