import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/app_background.dart';
import '../../../../core/widget/move_status_video.dart';
import '../../../home/widget/quote.dart';
import '../controllers/mover_home_controller.dart';
import '../widget/stat_of_day_poseted_move.dart';

class MoverHomeView extends GetView<MoverHomeController> {
  const MoverHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(child:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h,),
            //name and notification
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("MoveForce",style: textStyele.titleMedium!.copyWith(fontSize: 20.sp),),
                Stack(
                  children: [
                    Icon(Icons.notifications_none_outlined,size: 28,),
                    Positioned(
                      top: 1,
                      right: 0,
                      child: Container(
                        height: 15.h,
                        width: 15.w,
                        decoration: BoxDecoration(color: AppColors.secoundaryColor,shape: BoxShape.circle),
                        child: Center(child: Text("1",style: textStyele.labelLarge!.copyWith(color: AppColors.primaryColor,fontSize: 9,fontWeight: FontWeight.bold),)),

                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 16.h,),
            StatOfDayPosetedMove(),
            SizedBox(height: 24.h,),
            Text("Upcoming Moves & Updates",style: textStyele.titleMedium,),
            SizedBox(height: 16.h,),
            MoveStatusVideo()

          ],

        ),
      ),
      ),

    );
  }
}
