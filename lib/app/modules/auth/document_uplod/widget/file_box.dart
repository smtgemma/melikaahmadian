import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/app_colors.dart';

class FileBox extends StatelessWidget {
  String? titel ;
  bool? isClosed ;
  VoidCallback ? onPress ;
   FileBox({super.key,this.titel,this.onPress,this.isClosed});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      height: 68.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.greenColor.withAlpha(50),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greenColor, width: 2),
      ),
      child: Center(child: Row(children: [
        Container(
          height: 44,
           width: 44,
          decoration: BoxDecoration(
            color: AppColors.greenColor,
           shape: BoxShape.circle
          ),
          child: Icon(Icons.check,color: AppColors.primaryColor,size: 24,),

      ),
        SizedBox(width: 08,),
        Expanded(child: Text(titel ?? "",maxLines:01,style: textStyele.bodyMedium!.copyWith(color: AppColors.greenColor,),)),
        isClosed == true ? SizedBox() : IconButton(onPressed: onPress, icon: Icon(Icons.close,color: AppColors.greenColor,))

      ])),
    );
  }
}
