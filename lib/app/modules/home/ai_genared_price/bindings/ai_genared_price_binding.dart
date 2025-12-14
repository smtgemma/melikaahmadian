import 'package:get/get.dart';

import '../controllers/ai_genared_price_controller.dart';

class AiGenaredPriceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiGenaredPriceController>(
      () => AiGenaredPriceController(),
    );
  }
}
