import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../core/widget/app_image_frame_radious_widget.dart';
import '../../../../core/widget/move_video.dart';
import '../../../home/custom_furniture/widget/produc_countity.dart';
import '../../offer_review/widget/single_information.dart';
class OngingDetails extends StatelessWidget {
  String? name ;
  String? starRation ;
  String? reviewRating ;
   OngingDetails({super.key,this.name,this.starRation,this.reviewRating});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MoveVideo(),
        SizedBox(height: 24.h,),
        Text("Your mover", style: textStyele.titleLarge),
        SizedBox(height: 12.h),
        Stack(children: [
          Container(
            //  height: 150.h,
            padding: EdgeInsets.all(16.w),
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.secoundaryColor,borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppImageFrameRadiousWidget(radious: 25,),
                    SizedBox(width: 20.w,),
                    Column(
                      children: [
                        Text("Mike James",style: textStyele.titleMedium!.copyWith(color: AppColors.primaryColor),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset(Assets.iconsColorStar),
                                SizedBox(width: 04,),
                                Text(starRation ?? "4.5",style: textStyele.bodyMedium!.copyWith(color: AppColors.primaryColor,fontSize: 14),)
                              ],
                            ),
                            SizedBox(width: 08.w,),
                            Text( "${reviewRating ?? "152"} Reviews",style: textStyele.bodyMedium!.copyWith(color: AppColors.primaryColor)),
                          ],),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h,),
                Row(
                  children: [
                    Expanded(child: AppButton(containerColor: 1,child: true,titel: "Call",iconPath: Assets.iconsCall,)),
                    SizedBox(width: 12.w,),
                    Expanded(child: AppButton(borderColor: AppColors.textSecoundaryColor,child: true,titel: "Chat",iconPath: Assets.iconsChat,))
                  ],
                )



              ],
            ),
          ),
          Positioned(
            top: -40,
            left: -40,
            child: Container(
              height: 123.h,
              width: 123.w,
              decoration: BoxDecoration(color: AppColors.shadoColor.withAlpha(10),shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -60,
            child: Container(
              height: 123.h,
              width: 123.w,
              decoration: BoxDecoration(color: AppColors.shadoColor.withAlpha(10),shape: BoxShape.circle),
            ),
          )
        ],),
        SizedBox(height: 24.h),
        SingleInformation(isChild: true, titel: "Toronto, Canada"),
        SizedBox(height: 12.h),
        SingleInformation(
          isChild: true,
          titel: "Toronto, Canada",
          iconPath: Assets.iconsFrom,
        ),
        SizedBox(height: 24.h),
        Text("Time Details", style: textStyele.titleLarge),
        SizedBox(height: 12.h),
        SingleInformation(
          isChild: true,
          titel: "27th November 2025",
          iconPath: Assets.iconsCalender,
        ),
        SizedBox(height: 12.h),
        SingleInformation(
          isChild: true,
          titel: "10:30 AM",
          iconPath: Assets.iconsQuite,
        ),
        SizedBox(height: 24.h),
        Text("Selected House Type", style: textStyele.titleLarge),
        SizedBox(height: 12.h),
        SingleInformation(titel: "House"),
        SizedBox(height: 24.h),
        Text("Selected House Type", style: textStyele.titleLarge),
        SizedBox(height: 12.h),
        ProducCountity(isReview: true),
        AppButton(
          titel: "Request To Cancel Move",
          onPress: () {
         //   bottomSheet(context);
          },
        ),
      ],
    );
  }
}
