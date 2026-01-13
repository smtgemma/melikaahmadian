import 'package:get/get.dart';

import '../controllers/ai_analized_furniture_controller.dart';

class AiAnalizedFurnitureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiAnalizedFurnitureController>(
      () => AiAnalizedFurnitureController(),
    );
  }
}
