import 'package:get/get.dart';
import 'package:melikaahmadian/app/modules/mover/mover_chat/controllers/mover_chat_controller.dart';
import 'package:melikaahmadian/app/modules/notification/controllers/notification_controller.dart';

import '../../mover_home/controllers/mover_home_controller.dart';
import '../../mover_move/controllers/mover_move_controller.dart';
import '../../mover_move/mover_move_compledet_detils/controllers/mover_move_compledet_detils_controller.dart';
import '../../mover_profile/controllers/mover_profile_controller.dart';
import '../controllers/mover_navbar_controller.dart';

class MoverNavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverNavbarController>(() => MoverNavbarController());
    Get.lazyPut<MoverChatController>(() => MoverChatController());
    Get.lazyPut<MoverNavbarController>(() => MoverNavbarController());
    Get.lazyPut<MoverHomeController>(() => MoverHomeController());
    Get.lazyPut<MoverMoveController>(() => MoverMoveController(), fenix: true);
    Get.lazyPut<MoverProfileController>(() => MoverProfileController());
    Get.lazyPut<MoverMoveCompledetDetilsController>(
      () => MoverMoveCompledetDetilsController(),
    );
    Get.put(NotificationController());
  }
}
