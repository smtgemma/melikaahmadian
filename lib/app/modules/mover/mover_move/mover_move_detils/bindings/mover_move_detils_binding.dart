import 'package:get/get.dart';

import '../controllers/mover_move_detils_controller.dart';

class MoverMoveDetilsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverMoveDetilsController>(
      () => MoverMoveDetilsController(),
    );
  }
}
