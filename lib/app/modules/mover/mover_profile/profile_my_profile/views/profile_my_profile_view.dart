import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../core/const/app_colors.dart';
import '../../../../../core/widget/App_button.dart';
import '../../../../../core/widget/app_back_button.dart';
import '../../../../../core/widget/app_background.dart';
import '../../../../../core/widget/app_image_frame_radious_widget.dart';
import '../../../../auth/image_uplod/controllers/image_uplod_controller.dart';
import '../../../../move/mover_profiel_details/widget/about.dart';
import '../../../../move/mover_profiel_details/widget/experence_box.dart';
import '../../../../move/mover_profiel_details/widget/mover_review.dart';
import '../../../../move/mover_profiel_details/widget/specialties.dart';
import '../controllers/profile_my_profile_controller.dart';

class ProfileMyProfileView extends GetView<ProfileMyProfileController> {
  const ProfileMyProfileView({super.key});
  @override
  Widget build(BuildContext context) {
   // final imagecontroller = Get.put(ImageUplodController());
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 24,),
            //name and rating
            Stack(children: [
              Container(
                //  height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.secoundaryColor,borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 41.h,),
                    AppImageFrameRadiousWidget(radious: 50,),
                    SizedBox(height:08.h ,),
                    Center(
                      child: Column(
                        children: [
                          Text("Mike James",style: textStyele.titleLarge!.copyWith(color: AppColors.primaryColor),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Image.asset(Assets.iconsColorStar),
                                  SizedBox(width: 04,),
                                  Text( "4.5",style: textStyele.bodyMedium!.copyWith(color: AppColors.primaryColor,fontSize: 14),)
                                ],
                              ),
                              SizedBox(width: 08.w,),
                              Text( "${"152"} Reviews",style: textStyele.bodyMedium!.copyWith(color: AppColors.primaryColor)),
                            ],),
                        ],
                      ),
                    ),
                    SizedBox(height: 41.h,),

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
            SizedBox(height: 41,),
            // move and experice
            Row(
              children: [
                Expanded(child: ExperenceBo()),
                SizedBox(width: 12.w,),
                Expanded(child: ExperenceBo(iconsPath: Assets.iconsBag,color: AppColors.greenColor.withAlpha(10),title: "Years",rating: "5+",isbag: true,)),
              ],
            ),
            SizedBox(height: 24.h,),
            Text("Basic Information",style: textStyele.titleLarge  ,),
            SizedBox(height: 12.h),
            TextField(
              controller: controller.nameTextEditingController,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 12.h),
            TextField(
              controller: controller.phoneTextEditingController,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 12.h),
            TextField(
              controller: controller.emailTextEditingController,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 12.h),
            TextField(
              controller: controller.addressTextEditingController,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            //About
            About(),
            SizedBox(height: 24.h,),
            Specialties(),
            SizedBox(height: 24.h,),
            Text("Vehicle Photos",style: textStyele.titleLarge  ,),
            //image
            SizedBox(
              height: 250.h,
              child: GridView.builder(

                itemCount: 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,mainAxisSpacing: 5), itemBuilder: (context, index) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(Assets.imagesTruck)
                );
              },),
            ),
            //mover review
            MoverReview(),
            SizedBox(height: 24.h,),
            AppButton(child: true,iconPath: Assets.iconsProfileEdit,titel: "Edit Information",onPress: (){Get.toNamed(Routes.PROFILE_PROFILE_EDIT);},),
            SizedBox(height: 24.h,),





          ],
        ),
      ),),
    );
  }
}
