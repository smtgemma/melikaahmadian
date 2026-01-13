import 'package:get/get.dart';

import '../controllers/image_uplod_controller.dart';

class ImageUplodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageUplodController>(
      () => ImageUplodController(),
    );
  }
}
