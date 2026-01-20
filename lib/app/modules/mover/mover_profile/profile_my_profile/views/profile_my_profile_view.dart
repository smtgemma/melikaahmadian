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
import '../../controllers/mover_profile_controller.dart';
import '../controllers/profile_my_profile_controller.dart';

class ProfileMyProfileView extends GetView<ProfileMyProfileController> {
  const ProfileMyProfileView({super.key});
  @override
  Widget build(BuildContext context) {
   // final imagecontroller = Get.put(ImageUplodController());
    final profileController = Get.find<MoverProfileController>();
    var textStyele = TextTheme.of(context);
    return  RefreshIndicator(child: Scaffold(
      body: Obx(() =>  profileController.isLoading.value == true ? Center(child: CircularProgressIndicator(color: AppColors.secoundaryColor)) :  AppBackground(child: SingleChildScrollView(
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
                    Obx(() {
                      final data =
                          profileController.profileModel.value.data?.image;
                      if (data == null || data.isEmpty) {
                        return AppImageFrameRadiousWidget(
                          radious: 50,
                          imageLink:
                          "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTY1LWtsaGN3ZWNtLmpwZw.jpg",
                        );
                      }

                      return AppImageFrameRadiousWidget(
                        radious: 50,
                        imageLink:
                        profileController.profileModel.value.data?.image,
                      );
                    }),
                    SizedBox(height:08.h ,),
                    Center(
                      child: Column(
                        children: [
                          Obx(() => Text(profileController.profileModel.value.data?.fullName ?? "",style: textStyele.titleLarge!.copyWith(color: AppColors.primaryColor),),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Image.asset(Assets.iconsColorStar),
                                  SizedBox(width: 04,),
                                  Text( profileController.profileModel.value.data?.averageRating?.toStringAsFixed(1) ??"0.0",style: textStyele.bodyMedium!.copyWith(color: AppColors.primaryColor,fontSize: 14),)
                                ],
                              ),
                              SizedBox(width: 08.w,),
                              Text( "${profileController.profileModel.value.data?.totalReview ?? "0"} Reviews",style: textStyele.bodyMedium!.copyWith(color: AppColors.primaryColor)),
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
                Obx(() => Expanded(child: ExperenceBo(rating: profileController?.profileModel?.value?.data?.moves?.toString() ?? "0",),),),
                SizedBox(width: 12.w,),
                Obx(() {
                  // Get the created date from the profile
                  String date = profileController.profileModel.value?.data?.createdAt ?? "";

                  // Safety check: if date is empty, show 0
                  int experienceYears = 0;
                  if (date.isNotEmpty) {
                    DateTime createdDate = DateTime.parse(date);
                    DateTime now = DateTime.now();

                    experienceYears = now.year - createdDate.year;

                    // Adjust if current month/day is before created month/day
                    if (now.month < createdDate.month ||
                        (now.month == createdDate.month && now.day < createdDate.day)) {
                      experienceYears--;
                    }

                    // Ensure non-negative
                    if (experienceYears < 0) experienceYears = 0;
                  }

                  // Return your ExperienceBo widget
                  return Expanded(
                    child: ExperenceBo(
                      iconsPath: Assets.iconsBag,
                      color: AppColors.greenColor.withAlpha(10),
                      title: "Years",
                      rating: experienceYears.toString(),
                      isbag: true,
                    ),
                  );
                }),

              ],
            ),
            SizedBox(height: 24.h,),
            Text("Basic Information",style: textStyele.titleLarge  ,),
            SizedBox(height: 12.h),
            TextField(
              controller: profileController.nameTextEditingController,
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

            // SizedBox(height: 12.h),
            // TextField(
            //   controller: controller.phoneTextEditingController,
            //   readOnly: true,
            //   decoration: InputDecoration(
            //     filled: true,
            //     fillColor: AppColors.cardColor,
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //       borderSide: BorderSide.none,
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //       borderSide: BorderSide.none,
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //       borderSide: BorderSide.none,
            //     ),
            //     disabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //       borderSide: BorderSide.none,
            //     ),
            //   ),
            // ),

            SizedBox(height: 12.h),
            TextField(
              controller: profileController.emailTextEditingController,
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
            Obx(() =>   About(bio: profileController.profileModel.value.data?.bio ?? "",),),
            SizedBox(height: 24.h,),
            Specialties(specialties: profileController.selectedSpecialties.value ?? [],),
            SizedBox(height: 24.h,),
            Text("Vehicle Photos",style: textStyele.titleLarge,),
            //image
            SizedBox(
              height: 250.h,
              child: Obx(
                    () => GridView.builder(
                  itemCount: profileController.vehicleImages.value.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    final data = profileController.vehicleImages.value[index];

                    // If URL is null or empty, show placeholder
                    if (data == null || data.isEmpty) {
                      return AppImageFrameRadiousWidget(radious: 50);
                    }

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        data,
                        fit: BoxFit.cover,
                        // This handles invalid URLs
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child; // image loaded

                          return Container(
                            color: Colors.grey[300],
                            child:  Center(
                              child: CircularProgressIndicator(strokeWidth: 2,color: AppColors.secoundaryColor,),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

            //mover review
            SizedBox(height: 24.h,),
             MoverReview(),
            SizedBox(height: 24.h,),
            AppButton(child: true,iconPath: Assets.iconsProfileEdit,titel: "Edit Information",onPress: (){Get.toNamed(Routes.PROFILE_PROFILE_EDIT);},),
            SizedBox(height: 24.h,),





          ],
        ),
      ),),),
    ), onRefresh: (){
     // debugPrint("profile controller refresh ${profileController.profileModel.value.data?.id}") ;
      profileController.getProfile();
     controller.getReview(id: profileController.profileModel.value.data?.id);
      controller.refresh();
      return Future.delayed(const Duration(seconds: 1));
    });
  }
}
