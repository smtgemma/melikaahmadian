import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentDetailsController extends GetxController {
  //TODO: Implement PaymentDetailsController
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final addressController = TextEditingController();
  final StateaddressController = TextEditingController();
  final zipaddressController = TextEditingController();
  final alexCardController = TextEditingController();
  final mmCardController = TextEditingController();
  final cvcCardController = TextEditingController();
  final aledMeanCardController = TextEditingController();
  final countryOrRegonController = TextEditingController();


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
