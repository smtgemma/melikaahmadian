import 'package:get/get.dart';

import '../controllers/select_option_controller.dart';

class SelectOptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectOptionController>(
      () => SelectOptionController(),
    );
  }
}
