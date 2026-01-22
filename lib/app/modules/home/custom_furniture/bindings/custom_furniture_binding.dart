import 'package:get/get.dart';

import '../controllers/custom_furniture_controller.dart';

class CustomFurnitureBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomFurnitureController());
    // Get.lazyPut<CustomFurnitureController>(
    //   () => CustomFurnitureController(),fenix: true
    // );
  }
}
