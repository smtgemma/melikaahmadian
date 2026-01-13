import 'package:get/get.dart';

import '../controllers/video_cmera_controller.dart';

class VideoCmeraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoCmeraController>(
      () => VideoCmeraController(),
    );
  }
}
