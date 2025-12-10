import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  double? hight ;
  double? width ;
  double? textSize ;
  String? titel ;
  VoidCallback? onPress ;
  bool ? child;
  String ? iconPath ;
  Color? color ;
  int? containerColor;
  double? borderRadius ;

   AppButton({super.key,this.width,this.hight,this.titel,this.onPress,this.child,this.iconPath,this.color,this.containerColor = 0,this.textSize,this.borderRadius});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: hight ?? 52.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(color:  containerColor == 0 ? AppColors.secoundaryColor : AppColors.onPrimaryColor,borderRadius: BorderRadius.all(Radius.circular(borderRadius ??  08.r))),
        child: child == true ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath.toString(),color: color ,),
            SizedBox(width: 10.w,),
            Text(titel ?? "Save",style: textStyele.bodyLarge!.copyWith(color: containerColor == 0 ? AppColors.primaryColor : AppColors.secoundaryColor,fontSize: textSize,fontWeight: FontWeight.bold),),


          ],
        ) :
        Center(child: Text(titel ?? "Save",style: textStyele.bodyLarge!.copyWith(color: containerColor == 0 ? AppColors.primaryColor : AppColors.secoundaryColor,fontSize: textSize,fontWeight: FontWeight.bold),),),


      ),
    );
  }
}
