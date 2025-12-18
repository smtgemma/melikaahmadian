import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileChangePasswordController extends GetxController {
  //TODO: Implement ProfileChangePasswordController

  final passTextEditingController = TextEditingController();
  final confrimePassTextEditingController = TextEditingController();
  final oldPassTextEditingController = TextEditingController();
  final isVisibility = false.obs ;
  final isConfirmeVisibility = false.obs ;
  final isoldPassVisibility = false.obs ;

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

  void visibility(){
    isVisibility.value = !isVisibility.value ;
  }
  void confrimvisibility(){
    isConfirmeVisibility.value = !isConfirmeVisibility.value ;
  }
  void oldPass(){
    isConfirmeVisibility.value = !isConfirmeVisibility.value ;
  }
}
