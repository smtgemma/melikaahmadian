import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../widget/quote.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
     body: AppBackground(child:
     SingleChildScrollView(
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           SizedBox(height: 17.h,),
           //name and notification
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text("MoveForce",style: textStyele.titleMedium!.copyWith(fontSize: 20.sp),),
               InkWell(
                 onTap: (){
                   Get.toNamed(Routes.NOTIFICATION);
                 },
                 child: Stack(
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
                 ),
               )
             ],
           ),
           SizedBox(height: 24.h,),
           Quote(),
           SizedBox(height: 16.h,),
           Quote(ai: true,),
           SizedBox(height: 16.h,),
           Text("Upcoming Moves & Updates",style: textStyele.titleMedium,)

         ],

       ),
     ),
     ),

    );
  }
}
