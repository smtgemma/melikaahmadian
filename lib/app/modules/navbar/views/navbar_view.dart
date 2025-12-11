import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';

import '../../../../generated/assets.dart';
import '../../../core/widget/App_button.dart';
import '../../../core/widget/app_back_button.dart';
import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NavbarView'),
        centerTitle: true,
      ),
      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Center(
              child: Image.asset(Assets.iconsBack),
            ),
            AppBackButton(),
            SizedBox(
                width: 300,
                child: TextField()),
            AppButton(color: AppColors.dartRed,containerColor: 0,titel: "Continue As Service Provider",)

          ],
        ),
      ),
    );
  }
}
