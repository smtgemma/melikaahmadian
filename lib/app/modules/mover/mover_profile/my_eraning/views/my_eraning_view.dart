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
    var textStyele = TextTheme.of(context);

    return Scaffold(
     body: AppBackground(child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         AppBackButton(),
         SizedBox(height: 24.h,),
         Text("My Earning",style: textStyele.titleLarge,),
         SizedBox(height: 04.h,),
         Text("See how mush you have earned this month.",style: textStyele.bodyMedium,),
         SizedBox(height: 12.h,),
         SizedBox(
           height: 36.h,
           width: double.infinity,
           child:  ListView.builder(
             scrollDirection: Axis.horizontal,
             itemCount: controller.months.value.length,
             itemBuilder: (context, index) {
               var month = controller.months[index];
               return Obx(() => GestureDetector(
                   onTap: (){
                     controller.monthIndex.value = index;
                     controller.selectedMonth.value = month;
                   },
                   child: index == controller.monthIndex.value ? Padding(
                     padding:  EdgeInsets.symmetric(horizontal: 3),
                     child: AppButton(titel: month,width: 111.w,hight: 36,),
                   ) : Padding(
                     padding: EdgeInsets.symmetric(horizontal: 3),
                     child: AppButton(containerColor: 1,borderColor: AppColors.textSecoundaryColor,titel: month,width: 111.w,),
                   )  ),);

             },),
         ),
         SizedBox(height: 12.h,),
         Earning(price: "300",),
         BlanceSunmnary(totalmove: "300",totacommison: "300",totalbalance: "300",),
         SizedBox(height: 24.h,),
         Text("Completed Moves In This Month",style: textStyele.titleLarge,),
         SizedBox(height: 12.h,),
         MoveStatusVideo(isNavigator: true,titel: "Completed",color: AppColors.greenColor.withAlpha(10),textColor: AppColors.greenColor,isType: AppArgumentString.movercompeleted,isOffer: true,),








       ],
     ),),
    );
  }
}
