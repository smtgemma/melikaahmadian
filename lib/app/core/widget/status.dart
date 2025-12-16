import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';

class Status extends StatelessWidget {
  String? titel ;
  Color? color ;
  Color? textColor ;

   Status({super.key,this.titel,this.color,this.textColor});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Container(
      height: 29.h,
      width: 167.w,
      decoration: BoxDecoration(color:color ?? AppColors.BurntOrange.withOpacity(0.10),borderRadius: BorderRadius.circular(8)),
      padding:  EdgeInsets.all(0),
      child: Center(child: Text( titel ??"Posted",style: textStyele.bodyMedium!.copyWith(color: textColor ?? AppColors.BurntOrange,fontWeight: FontWeight.w500),),),
    ) ;
  }
}
