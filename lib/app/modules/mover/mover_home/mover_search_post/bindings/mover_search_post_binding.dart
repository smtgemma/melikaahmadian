import 'package:get/get.dart';

import '../controllers/mover_search_post_controller.dart';

class MoverSearchPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverSearchPostController>(
      () => MoverSearchPostController(),
    );
  }
}
