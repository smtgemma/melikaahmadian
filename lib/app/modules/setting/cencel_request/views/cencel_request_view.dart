import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../core/widget/move_status_video.dart';
import '../controllers/cencel_request_controller.dart';

class CencelRequestView extends GetView<CencelRequestController> {
  const CencelRequestView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
     body: AppBackground(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           AppBackButton(),
           Text("Move Cancel Request",style: textStyele.titleMedium,),
           SizedBox(height: 04.h),
           Text("Are you sure you want to cancel this move?",style: textStyele.bodyMedium,),
           SizedBox(height: 24.h),
           MoveStatusVideo(color: AppColors.errorColor.withAlpha(10),textColor: AppColors.errorColor,titel: "Cancel",isNavigator: true,isType: "cancelled",)


         ],
       ),
     ),
    );
  }
}
