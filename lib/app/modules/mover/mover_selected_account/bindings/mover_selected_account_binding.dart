import 'package:get/get.dart';

import '../controllers/mover_selected_account_controller.dart';

class MoverSelectedAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverSelectedAccountController>(
      () => MoverSelectedAccountController(),
    );
  }
}
