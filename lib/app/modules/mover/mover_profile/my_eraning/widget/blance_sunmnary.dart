import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';

class BlanceSunmnary extends StatelessWidget {
  final String? totalmove;
  final String? totacommison;
  final String? totalbalance;

  const BlanceSunmnary({
    super.key,
    this.totalmove,
    this.totacommison,
    this.totalbalance,
  });

  @override
  Widget build(BuildContext context) {
    var textStyle = TextTheme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Balance Summary",
            style: textStyle.titleLarge,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total completed move",
                style: textStyle.bodyMedium,
              ),
              Text(
                "\$${totalmove ?? '0'}",
                style: textStyle.titleMedium,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Company Commission",
                style: textStyle.bodyMedium,
              ),
              Text(
                "\$${totacommison ?? '0'}",
                style: textStyle.titleMedium,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Net Total",
                style: textStyle.titleLarge,
              ),
              Text(
                "\$${totalbalance ?? '0'}",
                style: textStyle.titleMedium?.copyWith(
                  color: AppColors.secoundaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}