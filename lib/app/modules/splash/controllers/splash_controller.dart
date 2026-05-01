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
  void onInit() {
    super.onInit();
    _initAndGoNext();
  }

  Future<void> _initAndGoNext() async {
    await getAccessToken();
    await Future.delayed(const Duration(seconds: 3));
    _goNext();
  }

  Future<void> getAccessToken() async {
    try {
      token.value =
          await SharedPrefHelper.getString(SharedPrefHelper.accessToken) ?? '';
      useRoll.value =
          await SharedPrefHelper.getString(SharedPrefHelper.userRoll) ?? '';
      debugPrint("🔵 Splash: Token='${token.value}', Role='${useRoll.value}'");
    } catch (e) {
      debugPrint("❌ Splash Error: $e");
    }
  }

  void _goNext() {
    if (token.value.isEmpty) {
      debugPrint("➡️ Navigating to SELECT_OPTION (No token)");
      Get.offAllNamed(Routes.SELECT_OPTION);
    } else if (useRoll.value == "PROVIDER" && token.value.isNotEmpty) {
      debugPrint("➡️ Navigating to MOVER_NAVBAR");
      Get.offAllNamed(Routes.MOVER_NAVBAR);
    } else if ((useRoll.value == "USER" || useRoll.value == "SUPERADMIN") && token.value.isNotEmpty) {
      debugPrint("➡️ Navigating to NAVBAR (Role: ${useRoll.value})");
      Get.offAllNamed(Routes.NAVBAR);
    } else {
      debugPrint("⚠️ Unknown role '${useRoll.value}', navigating to SELECT_OPTION");
      Get.offAllNamed(Routes.SELECT_OPTION);
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
