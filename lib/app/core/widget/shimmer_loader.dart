import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  const ShimmerWidget.rounded({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(milliseconds: 1500),
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.grey[400]!,
          shape: shapeBorder,
        ),
      ),
    );
  }
}

class MoverMoveStatusShimmer extends StatelessWidget {
  const MoverMoveStatusShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        height: 120.h,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Video Section Shimmer
            ShimmerWidget.rounded(
              width: 144.w,
              height: double.infinity,
            ),
            SizedBox(width: 12.w),
            // Content Section Shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // To Address
                  Row(
                    children: [
                      ShimmerWidget.circular(width: 16.w, height: 16.h),
                      SizedBox(width: 8.w),
                      Expanded(child: ShimmerWidget.rectangular(height: 12.h)),
                    ],
                  ),
                  // From Address
                  Row(
                    children: [
                      ShimmerWidget.circular(width: 16.w, height: 16.h),
                      SizedBox(width: 8.w),
                      Expanded(child: ShimmerWidget.rectangular(height: 12.h)),
                    ],
                  ),
                  // Status Button
                  ShimmerWidget.rounded(
                    width: 80.w,
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  final int itemCount;
  final Widget shimmerItem;

  const ShimmerList({
    super.key,
    this.itemCount = 5,
    required this.shimmerItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) => shimmerItem,
    );
  }
}

class MoverDetailsShimmer extends StatelessWidget {
  const MoverDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget.rectangular(height: 200.h),
          SizedBox(height: 24.h),
          ShimmerWidget.rectangular(width: 150.w, height: 24.h),
          SizedBox(height: 24.h),
          ShimmerWidget.rounded(height: 50.h),
          SizedBox(height: 12.h),
          ShimmerWidget.rounded(height: 145.h),
          SizedBox(height: 12.h),
          ShimmerWidget.rounded(height: 50.h),
          SizedBox(height: 12.h),
          ShimmerWidget.rounded(height: 145.h),
          SizedBox(height: 24.h),
          ShimmerWidget.rectangular(width: 120.w, height: 24.h),
          SizedBox(height: 12.h),
          ShimmerWidget.rounded(height: 50.h),
          SizedBox(height: 12.h),
          ShimmerWidget.rounded(height: 50.h),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class OfferShimmer extends StatelessWidget {
  const OfferShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        children: [
          ShimmerWidget.rectangular(height: 200.h),
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ListTile(
                  leading: ShimmerWidget.circular(width: 60.w, height: 60.h),
                  title: ShimmerWidget.rectangular(height: 16.h),
                  subtitle: ShimmerWidget.rectangular(width: 100.w, height: 12.h),
                ),
                SizedBox(height: 12.h),
                ShimmerWidget.rounded(height: 40.h),
                SizedBox(height: 12.h),
                ShimmerWidget.rounded(height: 94.h),
                SizedBox(height: 24.h),
                ShimmerWidget.rounded(height: 50.h),
                SizedBox(height: 12.h),
                ShimmerWidget.rounded(height: 50.h),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatTileShimmer extends StatelessWidget {
  const ChatTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            ShimmerWidget.circular(width: 56.r, height: 56.r),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget.rectangular(width: 120.w, height: 16.h),
                  SizedBox(height: 8.h),
                  ShimmerWidget.rectangular(width: 200.w, height: 12.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
