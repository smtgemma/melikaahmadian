import 'package:get/get.dart';

import '../controllers/prduct_details_controller.dart';

class PrductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrductDetailsController>(
      () => PrductDetailsController(),
    );
  }
}
