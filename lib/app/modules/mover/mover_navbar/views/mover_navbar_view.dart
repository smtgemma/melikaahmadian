import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/const/app_colors.dart';
import '../../../home/add_details/controllers/add_details_controller.dart';
import '../controllers/mover_navbar_controller.dart';
import 'package:get/get.dart';
class MoverNavbarView extends GetView<MoverNavbarController> {
  const MoverNavbarView({super.key});
  @override
  Widget build(BuildContext context) {
    final addItemController = Get.put(AddDetailsController());
    return Scaffold(
      body: Obx(() => controller.item[controller.selectedIndex.value]),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        height: 84.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.w),
            topLeft: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 08,
              spreadRadius: 0,
              offset: Offset(0, -0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
                  () => InkWell(
                onTap: () {
                  controller.selectedIndex.value = 0;
                },
                child: Image.asset(
                  Assets.iconsHome,
                  color: controller.selectedIndex.value == 0
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ),
            Obx(
                  () => InkWell(
                onTap: () {
                  controller.selectedIndex.value = 1;
                  addItemController.selectedDateText.value = "mover_move" ;
                },
                child: Image.asset(
                  Assets.iconsMove,
                  color: controller.selectedIndex.value == 1
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ),
            Obx(
                  () => InkWell(
                onTap: () {
                  controller.selectedIndex.value = 2;
                },
                child: Image.asset(
                  Assets.iconsChat,
                  color: controller.selectedIndex.value == 2
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ),
            Obx(
                  () => InkWell(
                onTap: () {
                  controller.selectedIndex.value = 3;
                },
                child: Image.asset(
                  Assets.iconsMenu,
                  color: controller.selectedIndex.value == 3
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
