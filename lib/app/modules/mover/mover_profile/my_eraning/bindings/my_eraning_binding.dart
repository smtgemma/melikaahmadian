import 'package:get/get.dart';

import '../controllers/my_eraning_controller.dart';

class MyEraningBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<MyEraningController>(
    //   () => MyEraningController(),
    // );

    Get.put(MyEraningController());
  }
}
