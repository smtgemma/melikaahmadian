import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/widget/shimmer_loader.dart';
import 'package:melikaahmadian/app/core/widget/move_status_video.dart';

import '../controllers/move_controller.dart';
import '../widget/move_catagory.dart';

class MoveView extends GetView<MoveController> {
  const MoveView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h,),
            Text("My Moves",style: textStyele.titleLarge,),
            SizedBox(height: 04.h,),
            Text("All your moves at one place",style: textStyele.bodyMedium,),
            SizedBox(height: 24.h,),
            MoveCatagory(),
            SizedBox(height: 10.h,),
            // MoveStatusVideo(isNavigator: true,isType: AppArgumentString.posted,),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const ShimmerList(shimmerItem: MoverMoveStatusShimmer());
            }

            final data = controller.moveModel.value.data;

            if (data == null || data.isEmpty) {
              return Center(
                child: Text(
                  "No Moves Found",
                  style: textStyele.titleMedium,
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                String apiDate = item.scheduleDate ?? "";
                String formattedDate = apiDate.split("T").first;

                final mediaList = item.media;
                final videoUrl = (mediaList != null && mediaList.isNotEmpty) ? mediaList[0].url : null;

                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: MoveStatusVideo(
                    isOffer: item.status == "CANCELLED" || item.status == "ONGOING" || item.status == "COMPLETED",
                    postId: item.id,
                    videoUrl: videoUrl,
                    from: item.dropoffAddress?.address ?? "",
                    to: item.pickupAddress?.address ?? "",
                    offer: item.status == "CANCELLED" ? "-1" : (item.totalOffers?.toString() ?? "0"),
                    date: formattedDate,
                    isNavigator: true,
                    titel: item.status ?? "",
                    color: _getStatusColor(item.status),
                    textColor: _getStatusTextColor(item.status),
                    isType: item.status ?? "",
                  ),
                );
              },
            );
          }),
        ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "POSTED":
        return AppColors.BurntOrange.withAlpha(25);
      case "ONGOING":
        return AppColors.blueColor.withAlpha(25);
      case "COMPLETED":
        return AppColors.greenColor.withAlpha(25);
      case "CANCELLED":
        return AppColors.errorColor.withAlpha(25);
      default:
        return AppColors.errorColor.withAlpha(25);
    }
  }

  Color _getStatusTextColor(String? status) {
    switch (status) {
      case "POSTED":
        return AppColors.BurntOrange;
      case "ONGOING":
        return AppColors.blueColor;
      case "COMPLETED":
        return AppColors.greenColor;
      case "CANCELLED":
        return AppColors.errorColor;
      default:
        return AppColors.errorColor;
    }
  }
}
