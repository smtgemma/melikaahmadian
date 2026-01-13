import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../../../core/const/app_colors.dart';

class SingleInformation extends StatelessWidget {
  String? iconPath ;
  bool? isChild ;
  String? titel ;
  String? subTitel ;
  VoidCallback? onPress ;

   SingleInformation({super.key,this.iconPath,this.isChild,this.titel,this.subTitel,this.onPress});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: AppColors.cardColor,borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          isChild == true ? Image.asset(iconPath ?? Assets.iconsTo) : SizedBox() ,
          isChild == true ? SizedBox(width: 8.w,) : SizedBox(),
          Text(titel ??"",style: textStyele.bodyMedium,)


        ],
      ),


    );
  }
}
