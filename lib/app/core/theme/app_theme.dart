import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../const/app_colors.dart';

class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.secoundaryColor,
          selectionColor: AppColors.secoundaryColor,
          selectionHandleColor: AppColors.secoundaryColor,
        ),

      scaffoldBackgroundColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryColor),
      iconTheme: IconThemeData(color: AppColors.secoundaryColor),
      textTheme: TextTheme(
          headlineLarge: TextStyle(fontSize: 28.sp,color:AppColors.textPrimaryColor,fontFamily: "uber" ,fontWeight: FontWeight.bold),
          headlineMedium:TextStyle(fontSize: 18.sp,color:AppColors.textPrimaryColor,fontFamily: "uber" ,fontWeight: FontWeight.bold),

          titleLarge: TextStyle(fontSize: 20.sp,color:AppColors.textPrimaryColor,fontFamily: "uber" ,fontWeight: FontWeight.bold),
          titleMedium:TextStyle(fontSize: 18.sp,color:AppColors.textPrimaryColor,fontFamily: "uber" ,fontWeight: FontWeight.w500),
          titleSmall:TextStyle(fontSize: 16.sp,color:AppColors.textPrimaryColor,fontFamily: "uber" ,fontWeight: FontWeight.w500) ,

          bodyLarge:TextStyle(fontSize: 18.sp,color:AppColors.textSecoundaryColor,fontFamily: "uber" ,fontWeight: FontWeight.w400) ,
          bodyMedium: TextStyle(fontSize: 16.sp,color:AppColors.textSecoundaryColor,fontFamily: "uber" ,fontWeight: FontWeight.w400),
          bodySmall: TextStyle(fontSize: 12.sp,color:AppColors.textSecoundaryColor,fontFamily: "uber" ,fontWeight: FontWeight.w400),

        labelLarge:TextStyle(fontSize: 14.sp,color:AppColors.textSecoundaryColor,fontFamily: "uber" ,fontWeight: FontWeight.w400),
        labelMedium: TextStyle(fontSize: 12.sp,color:AppColors.textSecoundaryColor,fontFamily: "uber" ,fontWeight: FontWeight.w400),
        labelSmall: TextStyle(fontSize: 10.sp,color:AppColors.textSecoundaryColor,fontFamily: "uber" ,fontWeight: FontWeight.w400),

      ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor:   AppColors.textSecoundaryColor.withAlpha(3),
          contentPadding:  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(08)),
            borderSide: BorderSide(
              width: 1,
              color: AppColors.textSecoundaryColor ,
            ),

          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(08)),
            borderSide: BorderSide(width: 1,
                color: AppColors.textSecoundaryColor
            ),
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(08)),
            borderSide: BorderSide(width: 1,
                color:AppColors.textSecoundaryColor
            ),
          ),
          hintStyle: TextStyle(fontSize: 14,color: AppColors.textPrimaryColor),


        )


    );
  }
}