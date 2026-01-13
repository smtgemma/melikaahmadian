import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../../../core/const/app_colors.dart';

class ExperenceBo extends StatelessWidget {
   String? iconsPath ;
   String? rating;
   String? title ;
   Color? color ;
   bool? isbag ;

   ExperenceBo({super.key,this.iconsPath,this.rating,this.title,this.color,this.isbag = false});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: BoxDecoration(color: color ?? AppColors.errorColor.withAlpha(10),borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         isbag == true ? SizedBox(height: 16.h,) : SizedBox(height: 4.h,),
          Image.asset(iconsPath ?? Assets.iconsTruckMoves),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(rating ??"247",style: textStyele.titleLarge,),
              SizedBox(width: 4.w,),
              Text(title ??"Moves",style: textStyele.bodyLarge!.copyWith(fontWeight: FontWeight.bold),)
            ],
          ),
        ],
      ),
    );
  }
}
