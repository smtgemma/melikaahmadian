import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument.dart';

class SpecialtyController extends GetxController {
  //TODO: Implement SpecialtyController
  final specilizTextController = TextEditingController();
  RxList specilized = [].obs ;
   String? bio ;
  @override
  void onInit() {
    final argument = Get.arguments ;
    bio = argument[AppArgument.bio];
    debugPrint("bio: ${bio}");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

}
