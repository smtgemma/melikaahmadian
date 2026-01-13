import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileMyProfileController extends GetxController {
  //TODO: Implement ProfileMyProfileController
  final nameTextEditingController = TextEditingController(text: "meskatul");
  final phoneTextEditingController = TextEditingController(text: "+880177777");
  final addressTextEditingController = TextEditingController(text: "Bangladesh");
  final emailTextEditingController = TextEditingController(text: "m*******@gmail.com");

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
