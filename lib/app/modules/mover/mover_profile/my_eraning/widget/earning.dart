import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/const/app_colors.dart';

class Earning extends StatelessWidget {
  final String? price;

  const Earning({super.key, this.price});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextTheme.of(context);

    return Stack(
      children: [
        Container(
          height: 150.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.secoundaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total Earning",
                style: textStyle.titleLarge?.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "\$${price ?? '0'}",
                style: textStyle.headlineLarge?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -40,
          left: -40,
          child: Container(
            height: 123.h,
            width: 123.w,
            decoration: BoxDecoration(
              color: AppColors.shadoColor.withAlpha(10),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -60,
          right: -60,
          child: Container(
            height: 123.h,
            width: 123.w,
            decoration: BoxDecoration(
              color: AppColors.shadoColor.withAlpha(10),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
