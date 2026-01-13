import 'package:get/get.dart';

import '../controllers/mover_chat_controller.dart';

class MoverChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverChatController>(
      () => MoverChatController(),
    );
  }
}
