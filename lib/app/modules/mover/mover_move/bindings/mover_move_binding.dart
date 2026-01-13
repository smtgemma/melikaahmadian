import 'package:get/get.dart';

import '../controllers/mover_move_controller.dart';

class MoverMoveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverMoveController>(
      () => MoverMoveController(),
    );
  }
}
