import 'package:get/get.dart';

import '../controllers/cencel_mover_details_controller.dart';

class CencelMoverDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CencelMoverDetailsController>(
      () => CencelMoverDetailsController(),
    );
  }
}
