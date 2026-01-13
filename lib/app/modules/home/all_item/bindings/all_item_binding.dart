import 'package:get/get.dart';

import '../controllers/all_item_controller.dart';

class AllItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllItemController>(
      () => AllItemController(),
    );
  }
}
