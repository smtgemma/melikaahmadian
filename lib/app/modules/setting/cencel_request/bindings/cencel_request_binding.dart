import 'package:get/get.dart';

import '../controllers/cencel_request_controller.dart';

class CencelRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CencelRequestController>(
      () => CencelRequestController(),
    );
  }
}
