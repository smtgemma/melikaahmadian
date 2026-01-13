import 'package:get/get.dart';

import '../controllers/review_evrything_controller.dart';

class ReviewEvrythingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewEvrythingController>(
      () => ReviewEvrythingController(),
    );
  }
}
