import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountWithEmailController extends GetxController {
  final nameTextEdittingController = TextEditingController();
  final phoneTextEdittingController = TextEditingController();
  final emailTextEdittingController = TextEditingController();

  final selectedCountryCode = '+880'.obs;
  final isTermsAccepted = false.obs; // Add this

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
    nameTextEdittingController.dispose();
    phoneTextEdittingController.dispose();
    emailTextEdittingController.dispose();
    super.onClose();
  }

  void toggleTerms() {
    isTermsAccepted.value = !isTermsAccepted.value;
  }

  void increment() => count.value++;
}
