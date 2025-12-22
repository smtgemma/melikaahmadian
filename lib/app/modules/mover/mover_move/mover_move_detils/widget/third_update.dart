import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../core/const/app_colors.dart';
class ThirdUpdate extends StatelessWidget {
  String ? titel ;
   ThirdUpdate({super.key,this.titel});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.greenColor.withAlpha(10),borderRadius: BorderRadius.all(Radius.circular(12)),border: Border.all(color: AppColors.greenColor)),
      child: Center(child: Row(children: [
        Image.asset(Assets.iconsRoundTik,color: AppColors.greenColor,),
        SizedBox(width: 10.w,),
        Expanded(child: AutoSizeText("On The Way To The Pickup Location",maxLines:1,style: textStyele.bodyMedium!.copyWith(color: AppColors.greenColor,fontWeight: FontWeight.bold),))
      ],),),
    );
  }
}
