import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_image_frame_radious_widget.dart';
import 'package:melikaahmadian/app/core/widget/move_video.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../mover_profiel_details/widget/experence_box.dart';

class Offer extends StatelessWidget {
  String? imageLink ;
  String? videoLink ;
  String? name ;
  String? starRation ;
  String? reviewRating ;
   Offer({super.key,this.imageLink,this.videoLink,this.name,this.starRation,this.reviewRating});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return  Column(
      children: [
        SizedBox(height: 200,
        child: MoveVideo(),
        ),
        Container(
          decoration: BoxDecoration(color: AppColors.cardColor,borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              ListTile(
                leading: AppImageFrameRadiousWidget(radious: 30,),
                title: Text(name?? "Mike James",style:textStyele.titleMedium),
                subtitle: Row(children:
                [
                  Row(
                    children: [
                      Image.asset(Assets.iconsColorStar),
                      SizedBox(width: 04,),
                      Text(starRation ?? "4.5",style: textStyele.bodyMedium!.copyWith(color: AppColors.secoundaryColor,fontSize: 14),)
                    ],
                  ),
                  SizedBox(width: 08.w,),
                  Text( "${reviewRating ?? "152"} Reviews",style: textStyele.bodyMedium),
                ],),

              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 3/1

                ), itemBuilder: (context, index) {
                return AppButton(containerColor: 1,titel: "Heavy Items",hight: 40,bodycolor: AppColors.primaryColor,borderColor: AppColors.textSecoundaryColor,);
              },),
              //offer price
              Stack(children: [
                Container(
                  height: 94.h,
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.secoundaryColor,borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Offered Price\n\$450",textAlign: TextAlign.center,style: textStyele!.titleLarge!.copyWith(color: AppColors.primaryColor),),
                      SizedBox(height: 4.h,),
                     // Obx(() => Text("\$${controller.price.value}",style: textStyele!.headlineLarge!.copyWith(color: AppColors.primaryColor),),)

                    ],
                  ),
                ),
                Positioned(
                  top: -20,
                  left: -20,
                  child: Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(color: AppColors.shadoColor.withAlpha(10),shape: BoxShape.circle),
                  ),
                ),
                Positioned(
                  bottom: -25,
                  right: -25,
                  child: Container(
                    height: 66.h,
                    width: 66.w,
                    decoration: BoxDecoration(color: AppColors.shadoColor.withAlpha(10),shape: BoxShape.circle),
                  ),
                )
              ],),
              SizedBox(height: 24.h,),
              AppButton(titel: "Accept Offer",),
              SizedBox(height: 12.h,),
              AppButton(containerColor: 1,titel: "View Profile",bodycolor: AppColors.primaryColor,borderColor: AppColors.secoundaryColor,onPress: (){Get.toNamed(Routes.MOVER_PROFIEL_DETAILS);},),
              SizedBox(height: 24.h,),

            ],
          ),
        )

      ],
    );
  }
}
