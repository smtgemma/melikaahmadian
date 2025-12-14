import 'package:get/get.dart';

import '../controllers/move_controller.dart';

class MoveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoveController>(
      () => MoveController(),
    );
  }
}
