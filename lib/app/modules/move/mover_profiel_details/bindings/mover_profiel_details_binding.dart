import 'package:get/get.dart';

import '../controllers/mover_profiel_details_controller.dart';

class MoverProfielDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverProfielDetailsController>(
      () => MoverProfielDetailsController(),
    );
  }
}
