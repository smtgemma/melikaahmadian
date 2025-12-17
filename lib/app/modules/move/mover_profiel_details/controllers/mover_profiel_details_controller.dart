import 'package:get/get.dart';

class MoverProfielDetailsController extends GetxController {
  //TODO: Implement MoverProfielDetailsController
  final isMore = true.obs ;
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

  void more (){
    isMore.value = !isMore.value ;
  }
}
