import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/widget/move_status_video.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../core/const/app_colors.dart';
import '../controllers/mover_serched_locationed_controller.dart';

class MoverSerchedLocationedView
    extends GetView<MoverSerchedLocationedController> {
  const MoverSerchedLocationedView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
     body: AppBackground(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           AppBackButton(),
           //
           SizedBox(height: 24.h,),
           Container(
             padding: EdgeInsets.all(16),
             decoration: BoxDecoration(color: AppColors.secoundaryColor,borderRadius: BorderRadius.circular(12)),
             child: Column(
               children: [
                 ListTile(
                   leading: Container(
                     padding: EdgeInsets.all(12),
                     decoration: BoxDecoration(color: AppColors.primaryColor,shape: BoxShape.circle),
                     child: Image.asset(Assets.iconsFlash),
                   ),
                   title: Text("12",style: textStyele.titleMedium!.copyWith(color: AppColors.primaryColor)),
                   subtitle: Text("New move post in your selected area.",style: textStyele.bodyMedium!.copyWith(color: AppColors.primaryColor),),


                 ),

               ],
             ),

           ),
           SizedBox(height: 24.h,),
           MoveStatusVideo(titel: "Offered",isOffer: true,isType: "one",isNavigator: true)
         ],
       ),
     ),
    );
  }
}
