import 'package:get/get.dart';

import '../controllers/mover_serched_locationed_controller.dart';

class MoverSerchedLocationedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverSerchedLocationedController>(
      () => MoverSerchedLocationedController(),
    );
  }
}
