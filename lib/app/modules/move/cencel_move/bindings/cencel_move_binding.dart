import 'package:get/get.dart';

import '../controllers/cencel_move_controller.dart';

class CencelMoveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CencelMoveController>(
      () => CencelMoveController(),
    );
  }
}
