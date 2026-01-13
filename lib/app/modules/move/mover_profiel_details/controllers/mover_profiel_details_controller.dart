import 'package:get/get.dart';

import '../model/porfile_model.dart';

class MoverProfielDetailsController extends GetxController {
  //TODO: Implement MoverProfielDetailsController
  final isMore = true.obs ;
  final count = 0.obs;
 // Rx<ProfileModel> profileModel = ProfileModel().obs ;

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
