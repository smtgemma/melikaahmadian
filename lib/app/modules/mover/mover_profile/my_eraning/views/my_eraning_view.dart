import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import '../../../../../core/const/app_argument_string.dart';
import '../../../../../core/widget/move_status_video.dart';
import '../controllers/my_eraning_controller.dart';
import '../widget/blance_sunmnary.dart';
import '../widget/earning.dart';

class MyEraningView extends GetView<MyEraningController> {
  const MyEraningView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyEraningController());
    var textStyle = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 24.h),
            Text("My Earning", style: textStyle.titleLarge),
            SizedBox(height: 04.h),
            Text(
              "See how much you have earned this month.",
              style: textStyle.bodyMedium,
            ),
            SizedBox(height: 12.h),

            // Month selection
            SizedBox(
              height: 36.h,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.months.length,
                itemBuilder: (context, index) {
                  var month = controller.months[index];
                  return Obx(
                        () => GestureDetector(
                      onTap: () {
                        controller.changeMonth(index, month);
                      },
                      child: index == controller.monthIndex.value
                          ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: AppButton(
                          titel: month,
                          width: 111.w,
                          hight: 36,
                        ),
                      )
                          : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: AppButton(
                          containerColor: 1,
                          borderColor: AppColors.textSecoundaryColor,
                          titel: month,
                          width: 111.w,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 12.h),

            // Main content with loading state
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.completedMovesList.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final monthlyEarnings = controller.myEarning.value?.data?.monthlyEarnings;

                return RefreshIndicator(
                  onRefresh: controller.refreshData,
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Earning widget
                        Earning(
                          price: monthlyEarnings?.netTotal?.toString() ?? "0",
                        ),

                        SizedBox(height: 12.h),

                        // Balance Summary
                        BlanceSunmnary(
                          totalmove: monthlyEarnings?.totalCompleted?.toString() ?? "0",
                          totacommison: monthlyEarnings?.companyCommission?.toString() ?? "0",
                          totalbalance: monthlyEarnings?.netTotal?.toString() ?? "0",
                        ),

                        SizedBox(height: 24.h),

                        Text(
                          "Completed Moves In This Month",
                          style: textStyle.titleLarge,
                        ),

                        SizedBox(height: 12.h),

                        // Completed moves list
                        controller.completedMovesList.isEmpty
                            ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text(
                              "No completed moves this month",
                              style: textStyle.bodyMedium,
                            ),
                          ),
                        )
                            : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.completedMovesList.length,
                          itemBuilder: (context, index) {
                            final move = controller.completedMovesList[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: MoveStatusVideo(
                                isNavigator: true,
                                titel: "Completed",
                                color: AppColors.greenColor.withAlpha(10),
                                textColor: AppColors.greenColor,
                                isType: AppArgumentString.movercompeleted,
                                isOffer: true,
                                // You can pass move data here if MoveStatusVideo accepts it
                                // moveData: move,
                              ),
                            );
                          },
                        ),

                        // Loading more indicator
                        if (controller.isLoadingMore.value)
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),

                        // No more data indicator
                        if (!controller.hasMore.value && controller.completedMovesList.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                "No more moves to load",
                                style: textStyle.bodySmall,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}