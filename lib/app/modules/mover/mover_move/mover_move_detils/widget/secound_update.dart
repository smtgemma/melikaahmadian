import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/modules/mover/mover_move/mover_move_detils/widget/first_update.dart';
import 'package:melikaahmadian/app/modules/mover/mover_move/mover_move_detils/widget/third_update.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../core/const/app_colors.dart';
class SecoundUpdate extends StatelessWidget {
  String ? titel ;
   SecoundUpdate({super.key,this.titel});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.onPrimaryColor,borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Center(child: Row(children: [
        Image.asset(Assets.iconsRoundTik,color: AppColors.secoundaryColor,),
        SizedBox(width: 10.w,),
        Expanded(child: Text( titel??"On The Way To The Pickup Location ",style: textStyele.bodyMedium!.copyWith(color: AppColors.secoundaryColor,fontWeight: FontWeight.bold),)),

      ],),),
    ) ;
  }
}
