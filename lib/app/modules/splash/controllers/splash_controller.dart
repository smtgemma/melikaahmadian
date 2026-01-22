import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../core/network/shared_prepharence_helper.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  final token = "".obs;
  final useRoll = "".obs;

  // @override
  // void onReady() {
  //   super.onReady();
  //   getAccessToken();
  // }

  @override
  onInit() {
    super.onInit();
    getAccessToken();
    Future.delayed(const Duration(seconds: 3), () {
      _goNext();
    });
  }

  Future<void> getAccessToken() async {
    token.value =
        await SharedPrefHelper.getString(SharedPrefHelper.accessToken) ?? '';
    useRoll.value =
        await SharedPrefHelper.getString(SharedPrefHelper.userRoll) ?? '';
  }

  Future<void> _goNext() async {
    if (token.value.isEmpty || token.value == null) {
      Get.offAllNamed(Routes.SELECT_OPTION);
    } else if (useRoll.value == "PROVIDER") {
      Get.offAllNamed(Routes.MOVER_NAVBAR);
    } else if (useRoll.value == "USER") {
      Get.offAllNamed(Routes.NAVBAR);
    }
  }
}

// class SplashController extends GetxController {
//   //TODO: Implement SplashController
//   final count = 0.obs;
//   @override
//   void onInit() {
//     super.onInit();
//     _goNext();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//   void _goNext() async {
//     await Future.delayed(const Duration(seconds: 3));
//     debugPrint("max");
//       final accessToken = await SharedPrefHelper.getString(SharedPrefHelper.accessToken);
//       final userRoll = await SharedPrefHelper.getString(SharedPrefHelper.userRoll);
//
//       if(accessToken != null && userRoll == "PROVIDER"){
//         Get.offAllNamed(Routes.MOVER_NAVBAR);
//
//       }else if(accessToken != null && userRoll == "USER"){
//         Get.offAllNamed(Routes.NAVBAR);
//       }else{
//         Get.offAllNamed(Routes.SELECT_OPTION);
//
//       }
//     Get.offAllNamed(Routes.SELECT_OPTION);
//
//
//
//   }
//
// }
