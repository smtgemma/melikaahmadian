import 'package:get/get.dart';

import '../controllers/ongoing_move_update_controller.dart';

class OngoingMoveUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OngoingMoveUpdateController>(
      () => OngoingMoveUpdateController(),
    );
  }
}
