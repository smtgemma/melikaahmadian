import 'package:get/get.dart';

import '../controllers/ongoing_mover_details_controller.dart';

class OngoingMoverDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OngoingMoverDetailsController>(
      () => OngoingMoverDetailsController(),
    );
  }
}
