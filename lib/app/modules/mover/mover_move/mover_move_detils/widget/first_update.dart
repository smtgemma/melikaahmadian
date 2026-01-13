import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../core/const/app_colors.dart';
class FirstUpdate extends StatelessWidget {
  String ? titel ;
   FirstUpdate({super.key,this.titel});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.onPrimaryColor,borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Center(child: Row(children: [
        Image.asset(Assets.iconsRoundTik,color: AppColors.primaryColor,),
        SizedBox(width: 10.w,),
        Expanded(child: AutoSizeText( titel ??"On The Way To The Pickup Location ",style: textStyele.bodyMedium!.copyWith(color: AppColors.primaryColor,fontWeight: FontWeight.bold),))
      ],),),
    );
  }
}
