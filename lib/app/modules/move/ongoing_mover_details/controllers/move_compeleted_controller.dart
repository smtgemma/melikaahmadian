import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import 'package:melikaahmadian/app/core/network/shared_prepharence_helper.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../routes/app_pages.dart';

class MoveCompeletedController extends GetxController {
  RxInt ratingValue = 0.obs;

  final consumerController = TextEditingController();
  final _networkCaller = DioClient();
  final myId = ''.obs;
  final isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    getMyId();
    bottomSheet(Get.context!);
  }

  Future<void> getMyId() async {
    myId.value =
        await SharedPrefHelper.getString(SharedPrefHelper.userId) ?? '';
  }

  void bottomSheet(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 320.h,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.w)),
          ),
          child: Column(
            children: [
              Text("Rate The Mover", style: textStyle.titleMedium),
              SizedBox(height: 12.h),

              /// ⭐ STAR RATING
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return InkWell(
                      onTap: () {
                        ratingValue.value = index + 1;
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Image.asset(
                          ratingValue.value > index
                              ? Assets.iconsYellowStar
                              : Assets.iconsWhiteStar,
                          width: 28.w,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: 16.h),

              /// ✍ COMMENT
              TextField(
                controller: consumerController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.strtoColor.withAlpha(8),
                  hintText:
                      "The mover completed his move in a very organized way. Recommended.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              /// 🚀 SUBMIT
              Obx(() {
                return SizedBox(
                  height: 48.h,
                  child: isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : AppButton(
                          titel: "Submit",
                          onPress: () {
                            giveReview("695cda03145644bdceeeb3ce");
                          },
                        ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  /// ✅ API CALL (DYNAMIC)
  Future<void> giveReview(String postId) async {
    if (ratingValue.value == 0) {
      Get.snackbar(
        "Rating Required",
        "Please select at least 1 star",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await _networkCaller.post(
        AppUrls.giveReview,
        data: {
          "revieweeId": myId.value,
          "postId": postId,
          "rating": ratingValue.value.toDouble(),
          "comment": consumerController.text.trim(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        Get.toNamed(Routes.NAVBAR);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
