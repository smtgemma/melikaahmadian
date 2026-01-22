import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MoverSearchPostController extends GetxController {
  //TODO: Implement MoverSearchPostController
  final pickupController = TextEditingController();
  final dropoffController = TextEditingController();

  RxString picacity =  "".obs;
  RxString dropcity =  "".obs;
  RxString dropstate =  "".obs;
  RxString picstate =  "".obs;




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
