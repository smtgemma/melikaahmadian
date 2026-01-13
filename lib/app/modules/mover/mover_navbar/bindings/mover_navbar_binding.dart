import 'package:get/get.dart';

import '../controllers/mover_navbar_controller.dart';

class MoverNavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverNavbarController>(
      () => MoverNavbarController(),
    );
  }
}
