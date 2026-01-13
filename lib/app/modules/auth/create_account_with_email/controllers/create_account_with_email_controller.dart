import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountWithEmailController extends GetxController {
  //TODO: Implement CreateAccountWithEmailController

  final nameTextEdittingController = TextEditingController();
  final phoneTextEdittingController = TextEditingController();
  final emailTextEdittingController = TextEditingController();

  final selectedCountryCode = '+880'.obs;


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
