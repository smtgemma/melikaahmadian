import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _goNext();
  }

  @override
  void onReady() {
    super.onReady();
  }
  void _goNext() async {
    await Future.delayed(const Duration(seconds: 3));
    debugPrint("max");
    Get.offAllNamed(Routes.SELECT_OPTION);
  }

}
