import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/generated/assets.dart';

class DocumentFeatur extends StatefulWidget {
  const DocumentFeatur({super.key});

  @override
  State<DocumentFeatur> createState() => _DocumentFeaturState();
}

class _DocumentFeaturState extends State<DocumentFeatur> {
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Column(
      children: [
       Container(
         padding: EdgeInsets.only(top: 12.h,bottom: 12.h,left: 16.w,),
         decoration: BoxDecoration(color: AppColors.onPrimaryColor,borderRadius:BorderRadius.circular(12)),
         child: Row(
           children: [
             Container(
               height: 44,
               width: 44,
               decoration: BoxDecoration(color: AppColors.primaryColor,shape: BoxShape.circle),
               child: Image.asset(Assets.iconsBook),
             ),
             SizedBox(width: 12.w,),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("Upload document",style: textStyele.bodyMedium!.copyWith(color: AppColors.secoundaryColor,fontWeight: FontWeight.bold),),
                 Text("Driving license & verification docs.",style: textStyele.bodyMedium!.copyWith(fontSize: 14.sp),)
               ],
             )
           ],
         ),
       ),
       SizedBox(height: 12,),
       Container(
         padding: EdgeInsets.only(top: 12.h,bottom: 12.h,left: 16.w,),
         decoration: BoxDecoration(color: AppColors.onPrimaryColor,borderRadius:BorderRadius.circular(12)),
         child: Row(
           children: [
             Container(
               height: 44,
               width: 44,
               decoration: BoxDecoration(color: AppColors.primaryColor,shape: BoxShape.circle),
               child: Image.asset(Assets.iconsVanTrack),
             ),
             SizedBox(width: 12.w,),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("Vehicle Photos",style: textStyele.bodyMedium!.copyWith(color: AppColors.secoundaryColor,fontWeight: FontWeight.bold),),
                 Text("Photos of your truck or van.",style: textStyele.bodyMedium!.copyWith(fontSize: 14.sp),)
               ],
             )
           ],
         ),
       )
      ],
    );
  }
}
