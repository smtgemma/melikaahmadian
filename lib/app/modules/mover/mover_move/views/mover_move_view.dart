import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../core/const/app_argument_string.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/app_background.dart';
import '../../../../core/widget/move_status_video.dart';
import '../../../home/custom_furniture/widget/catagory.dart';
import '../controllers/mover_move_controller.dart';

class MoverMoveView extends GetView<MoverMoveController> {
  const MoverMoveView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h,),
              Text("My Moves",style: textStyele.titleLarge,),
              SizedBox(height: 04.h,),
              Text("All your moves at one place",style: textStyele.bodyMedium,),
              SizedBox(height: 24.h,),
              Catagory(),
              MoveStatusVideo(titel: "Offered",isOffer: true,isType: AppArgumentString.Offered,isNavigator: true),
              MoveStatusVideo(titel: "Ongoing",isOffer: true,isType: AppArgumentString.moverOngoing,isNavigator: true,color: AppColors.blueColor.withAlpha(10),textColor: AppColors.blueColor,),
              MoveStatusVideo(isNavigator: true,titel: "Cancel Requested",color: AppColors.errorColor.withAlpha(10),textColor: AppColors.errorColor,isType: AppArgumentString.cancelled,),
              MoveStatusVideo(isNavigator: true,titel: "Completed",color: AppColors.greenColor.withAlpha(10),textColor: AppColors.greenColor,isType: AppArgumentString.movercompeleted,),
              MoveStatusVideo(isNavigator: true,titel: "Cancelled",color: AppColors.errorColor.withAlpha(10),textColor: AppColors.errorColor,isType: AppArgumentString.movercenceled,),
          
          
            ],
          ),
        ),
      ),
    );
  }
}
