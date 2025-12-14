import 'package:get/get.dart';

import '../controllers/review_video_controller.dart';

class ReviewVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewVideoController>(
      () => ReviewVideoController(),
    );
  }
}
