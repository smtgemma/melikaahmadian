import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SetNewPasswordController extends GetxController {
  //TODO: Implement SetNewPasswordController

  final passTextEditingController = TextEditingController();
  final confrimePassTextEditingController = TextEditingController();
  final isVisibility = false.obs ;
  final isConfirmeVisibility = false.obs ;


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
  void visibility(){
    isVisibility.value = !isVisibility.value ;
  }
  void confrimvisibility(){
    isVisibility.value = !isVisibility.value ;
  }

}
