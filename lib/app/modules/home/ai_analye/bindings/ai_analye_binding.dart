import 'package:get/get.dart';

import '../controllers/ai_analye_controller.dart';

class AiAnalyeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiAnalyeController>(
      () => AiAnalyeController(),
    );
  }
}
