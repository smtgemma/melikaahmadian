import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../routes/app_pages.dart';
class MoveCompeletedController extends GetxController {
  
  RxList rating = [].obs ;
  RxInt ratingValue = 0.obs ;

  final consumerController = TextEditingController();


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print("max");
    bottomSheet( Get.context!) ;
  }

  void bottomSheet(BuildContext context) {
    var textStyele = TextTheme.of(context);
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        width: double.infinity,
        height: 300.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.w),
            topRight: Radius.circular(24.w),
          ),
        ),
        child: Column(
          children: [
            Text("Rate The Mover", style: textStyele.titleMedium),
            SizedBox(height: 12.h),
            // rating
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return InkWell(
                    onTap: () {
                      rating.clear();
                      for (int i = 0; i <= index; i++) {
                        rating.add((i + 1).toString());
                      }
                      ratingValue.value = index + 1;
                      update();
                      debugPrint(ratingValue.value.toString());
                               },
                    child: Obx(() =>
                    rating.length > index
                        ? Image.asset(Assets.iconsYellowStar)
                        : Image.asset(Assets.iconsWhiteStar),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 12.w,),
            Expanded(
              child: TextField(
                controller: consumerController,
                maxLines: 4,
                cursorHeight: 20,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.strtoColor.withAlpha(5) ,
                  hintText: "The mover completed his move in a very organized way. Recommended."
                ),
              ),
            ),
            SizedBox(height: 12.w,),
           AppButton(titel: "Submit",onPress: (){Get.toNamed(Routes.NAVBAR);},)
          ],
        ),
      );

    },) ;

  }


}