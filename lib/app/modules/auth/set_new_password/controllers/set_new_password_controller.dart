import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SetNewPasswordController extends GetxController {
  //TODO: Implement SetNewPasswordController

  final passTextEditingController = TextEditingController();
  final confrimePassTextEditingController = TextEditingController();
  final isVisibility = false.obs ;
  final isConfirmeVisibility = false.obs ;
  final isLoading = false.obs ;

  String? email ;


  @override
  void onInit() {
    final args = Get.arguments;
    final email = args?['email'];

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
  void visibility(){
    isVisibility.value = !isVisibility.value ;
  }
  void confrimvisibility(){
    isConfirmeVisibility.value = !isConfirmeVisibility.value ;
  }

}
