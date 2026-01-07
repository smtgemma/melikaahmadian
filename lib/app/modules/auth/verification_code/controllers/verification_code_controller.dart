import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerificationCodeController extends GetxController {
  //TODO: Implement VerificationCodeController

  final count = 0.obs;
  final otpTextEditingController = TextEditingController();
  final isLoading = false.obs ;
  String? email ;


  @override
  void onInit() {
    final args = Get.arguments;
    email = args["email"];
    debugPrint("argu email" + email.toString());
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
