import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';

import '../../../../generated/assets.dart';
import '../../../core/widget/App_button.dart';
import '../../../core/widget/app_back_button.dart';
import '../../home/add_details/controllers/add_details_controller.dart';
import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({super.key});
  @override
  Widget build(BuildContext context) {
    final addItemController = Get.find<AddDetailsController>();
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
                  addItemController.selectedDateText.value = "mover" ;
                },
                child: Image.asset(
                  Assets.iconsMove,
                  color: controller.selectedIndex.value == 1
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                controller.selectedIndex.value = 2;
              },
              child: Image.asset(Assets.iconsVideoAi),
            ),
            Obx(
              () => InkWell(
                onTap: () {
                  controller.selectedIndex.value = 3;
                },
                child: Image.asset(
                  Assets.iconsChat,
                  color: controller.selectedIndex.value == 3
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ),
            Obx(
              () => InkWell(
                onTap: () {
                  controller.selectedIndex.value = 4;
                },
                child: Image.asset(
                  Assets.iconsMenu,
                  color: controller.selectedIndex.value == 4
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
