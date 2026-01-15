import 'package:get/get.dart';

class MoverMoveCompledetDetilsController extends GetxController {
  //TODO: Implement MoverMoveCompledetDetilsController
  String moveType = "";

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    final argu = Get.arguments;
    moveType = argu["moveType"];


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
