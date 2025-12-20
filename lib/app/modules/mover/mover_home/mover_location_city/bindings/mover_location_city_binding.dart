import 'package:get/get.dart';

import '../controllers/mover_location_city_controller.dart';

class MoverLocationCityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverLocationCityController>(
      () => MoverLocationCityController(),
    );
  }
}
