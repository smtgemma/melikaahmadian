import 'package:get/get.dart';

import '../controllers/application_submit_controller.dart';

class ApplicationSubmitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationSubmitController>(
      () => ApplicationSubmitController(),
    );
  }
}
