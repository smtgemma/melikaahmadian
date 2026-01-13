import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    var textStyle = TextTheme.of(context);
    return Scaffold(
      body:  Center(
        child: Text( "MOVEFORCE", style: textStyle.headlineLarge!.copyWith(fontSize: 44.sp),
        ),
      ),
    );
  }
}
