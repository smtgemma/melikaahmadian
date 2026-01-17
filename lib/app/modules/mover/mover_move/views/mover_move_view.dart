import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../core/const/app_argument_string.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/app_background.dart';
import '../../../../core/widget/move_status_video.dart';
import '../../../../core/widget/mover_move_video_status.dart';
import '../../../home/custom_furniture/widget/catagory.dart';
import '../controllers/mover_move_controller.dart';
import '../widget/mover_move_catagory.dart';

class MoverMoveView extends GetView<MoverMoveController> {
  const MoverMoveView({super.key});
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
            MoverMoveCatagory(),
            SizedBox(height: 12.h,),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secoundaryColor,
                    ),
                  );
                }

                final data = controller.moveModel.value.data?.data;

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
                    String apiDate = item.createdAt ?? "";

                    String formattedDate = apiDate.split("T").first;

                    print(formattedDate); // 2026-01-10
                    return Padding(
                      padding:  EdgeInsets.only(bottom: 10),
                      child: MoverMoveStatusVideo(
                        isOffer:true ,
                        postId: item?.postId,
                        videoUrl: item?.post?.media?[0].url,
                        from: item?.post?.dropoffAddress?.address ?? "",
                        to: item?.post?.pickupAddress?.address ?? "",
                       // offer:  item?.status == "CANCELLED" ? "-1": item?.totalOffers.toString() ?? "",
                        date: formattedDate,
                        isNavigator: true,
                        titel: item.status ?? "",
                        color: item?.status == "PENDING" ?   AppColors.BurntOrange.withAlpha(10) : item?.status == "ACCEPTED" ?  AppColors.blueColor.withAlpha(10) : item?.status == "COMPLETED" ?  AppColors.greenColor.withAlpha(10) : item?.status == "CANCELLED" ?  AppColors.errorColor.withAlpha(10) : item?.status == "CANCELLED" ?  AppColors.errorColor.withAlpha(10) : AppColors.errorColor.withAlpha(10),
                        textColor: item?.status == "PENDING" ?  AppColors.BurntOrange : item?.status == "ACCEPTED" ?  AppColors.blueColor : item?.status == "COMPLETED" ?  AppColors.greenColor : item?.status == "CANCELLED" ?  AppColors.errorColor :item?.status == "CANCELLED" ?  AppColors.errorColor : AppColors.errorColor ,
                        isType: item?.status ?? "",
                      ),
                    );
                  },
                );

              },),
            )
            // MoveStatusVideo(titel: "Offered",isOffer: true,isType: AppArgumentString.Offered,isNavigator: true),
            // MoveStatusVideo(titel: "Ongoing",isOffer: true,isType: AppArgumentString.moverOngoing,isNavigator: true,color: AppColors.blueColor.withAlpha(10),textColor: AppColors.blueColor,),
            // MoveStatusVideo(isNavigator: true,titel: "Cancel Requested",color: AppColors.errorColor.withAlpha(10),textColor: AppColors.errorColor,isType: AppArgumentString.cancelled,),
            // MoveStatusVideo(isNavigator: true,titel: "Completed",color: AppColors.greenColor.withAlpha(10),textColor: AppColors.greenColor,isType: AppArgumentString.movercompeleted,),
            // MoveStatusVideo(isNavigator: true,titel: "Cancelled",color: AppColors.errorColor.withAlpha(10),textColor: AppColors.errorColor,isType: AppArgumentString.movercenceled,),


          ],
        ),
      ),
    );
  }
}
