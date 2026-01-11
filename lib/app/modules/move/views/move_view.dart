import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/widget/move_status_video.dart';
import 'package:melikaahmadian/app/modules/home/custom_furniture/widget/catagory.dart';

import '../../../core/widget/move_video.dart';
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
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.secoundaryColor,
                ),
              );
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

                print(formattedDate); // 2026-01-10
                return MoveStatusVideo(
                  videoUrl: item?.media?[0].url,
                  from: item?.dropoffAddress?.address ?? "",
                  to: item?.pickupAddress?.address ?? "",
                  offer: (item?.cCount ?? 0).toString(),
                  date: formattedDate,
                  isNavigator: true,
                  titel: item.status ?? "",
                  color: item?.status == "POSTED" ?   AppColors.BurntOrange.withAlpha(10) : item?.status == "ONGOING" ?  AppColors.blueColor.withAlpha(10) : item?.status == "COMPLETED" ?  AppColors.greenColor.withAlpha(10) : item?.status == "CANCELLED" ?  AppColors.errorColor.withAlpha(10) : AppColors.errorColor.withAlpha(10),
                  textColor: item?.status == "POSTED" ?  AppColors.BurntOrange : item?.status == "ONGOING" ?  AppColors.blueColor : item?.status == "COMPLETED" ?  AppColors.greenColor : item?.status == "CANCELLED" ?  AppColors.errorColor : AppColors.errorColor ,
                  isType: item?.status ?? "",

                );
              },
            );
          }),
        ),

            // SizedBox(height: 10.h,),
            // MoveStatusVideo(isNavigator: true,titel: "Ongoing",color: AppColors.hardBlueColor.withAlpha(10),textColor: AppColors.hardBlueColor,isType: AppArgumentString.ongoing,),
            // SizedBox(height: 10.h,),
            // MoveStatusVideo(isNavigator: true,titel: "Cancel Requested",color: AppColors.errorColor.withAlpha(10),textColor: AppColors.errorColor,isType: AppArgumentString.cancelled,)

          ],
        ),
      ),
    );
  }
}
