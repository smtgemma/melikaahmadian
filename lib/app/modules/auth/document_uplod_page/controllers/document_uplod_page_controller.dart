import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument.dart';

class DocumentUplodPageController extends GetxController {
  //TODO: Implement DocumentUplodPageController

  String? bio  ;
  List? specilize ;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    debugPrint("upload page");
    final argument = Get.arguments as Map<String, dynamic>?;
    if (argument == null) {
      debugPrint("No arguments received");
      return;
    }

    bio = argument[AppArgument.bio];
    specilize = argument[AppArgument.specializ];

    debugPrint("✅ bio : $bio");
    debugPrint("✅ specilize : $specilize");
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
