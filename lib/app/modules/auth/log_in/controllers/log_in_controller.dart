import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  //TODO: Implement LogInController
  final emailTextEditingController = TextEditingController();
  final passTextEditingController = TextEditingController();
  final isVisibility = false.obs ;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void visibility(){
    isVisibility.value = !isVisibility.value ;
  }

}
