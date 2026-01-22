import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';

import '../model/mover_searse_post_model.dart';
import '../repository/mover_searse_post_repositoy.dart';

class MoverLocationCityController extends GetxController {
  //TODO: Implement MoverLocationCityController

  RxBool isLoading = false.obs;

  bool? isType ;

  /// ✅ This will store ONLY POSTED items
  Rx<MoverSearsePostModel> postItems = MoverSearsePostModel().obs;


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    final argu = Get.arguments;

    isType =  argu?[AppArgumentString.ispicup];
    debugPrint("fw${isType}");
    getAddress();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAddress() async {
    try {
      isLoading.value = true;

      final result = await MoverSearsePostRepositoy.getProfile();
      postItems.value = result;


    } catch (e) {
      debugPrint("moves post  Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
