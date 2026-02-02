import 'package:get/get.dart';

import '../controllers/mover_account_controller.dart';

class MoverAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverAccountController>(
      () => MoverAccountController(),
    );
  }
}
