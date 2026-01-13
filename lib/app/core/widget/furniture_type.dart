import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
class FurnitureType extends StatelessWidget {
  String? titel ;
  String? quantity ;
  bool? isReview ;
  String? reviewCount ;
   FurnitureType({super.key,this.isReview,this.reviewCount,this.titel,this.quantity});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return  Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.onPrimaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text( titel ?? "gegr",style: textStyele.bodyMedium!.copyWith(color: AppColors.secoundaryColor,fontWeight: FontWeight.bold),),

          itemDecoration(child:Text( quantity ?? "egegre",style: textStyele.bodyMedium!.copyWith(color: AppColors.secoundaryColor,fontWeight: FontWeight.bold),), )




        ],),
    );;
  }
  Widget itemDecoration({Widget? child,double? width,double? horizontal ,double? vartical ,Color? color,double? hight }){
    return Container(
      width: width,
      height: hight,
      padding: EdgeInsets.symmetric(horizontal:horizontal ?? 11.w,vertical: vartical ?? 12.h),
      decoration: BoxDecoration(color: color ?? AppColors.primaryColor,borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }
}
