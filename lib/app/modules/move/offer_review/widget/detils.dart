import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/move_video.dart';
import 'package:melikaahmadian/app/modules/move/offer_review/widget/single_information.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../../../home/custom_furniture/widget/produc_countity.dart';
import 'package:get/get.dart';

import '../controllers/offer_review_controller.dart';
class Detils extends StatelessWidget {
  const Detils({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OfferReviewController>();
    var textStyele = TextTheme.of(context);
    return  Expanded(
      child: Obx(() {
        if(controller.detailsLoading.value){
          return Center(child: CircularProgressIndicator(color: AppColors.secoundaryColor,),);
        }
        return ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoveVideo(videoPath: controller.detailsmodel.value.data?.media?[0].url ?? "",),
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
                  titel: "Cancel Move",
                  onPress: () {
                    bottomSheet(context);
                  },
                ),
              ],
            ) ;
          },) ;
      },),
    );
  }

  void bottomSheet(BuildContext context) {
    var textStyele = TextTheme.of(context);
    showModalBottomSheet(
      backgroundColor: AppColors.primaryColor,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SizedBox(
          height: 350, // 🔹 bottom sheet height
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              child: ListView(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 08),
                    child: AppButton(
                      titel: "Wrong address added",
                      onPress: (){
                        Get.toNamed(Routes.NAVBAR);
                      },
                      containerColor: 1,
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
