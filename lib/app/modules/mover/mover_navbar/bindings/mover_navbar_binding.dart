import 'package:get/get.dart';
import 'package:melikaahmadian/app/modules/mover/mover_chat/controllers/mover_chat_controller.dart';

import '../controllers/mover_navbar_controller.dart';

class MoverNavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverNavbarController>(() => MoverNavbarController());
    Get.lazyPut<MoverChatController>(() => MoverChatController());
  }
}
