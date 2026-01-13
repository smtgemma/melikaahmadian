import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/const/app_argument.dart';

class ReviewEvrythingController extends GetxController {
  //TODO: Implement ReviewEvrythingController

  final count = 0.obs;
  String? bio ;
  List? specilize ;
  List? document ;
  List? vehiclePhoto ;
  final uploadProgress = "".obs ;
  final isLoading = false.obs ;

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
