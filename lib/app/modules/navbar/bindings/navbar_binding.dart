import 'package:get/get.dart';
import 'package:melikaahmadian/app/modules/mover/mover_chat/controllers/mover_chat_controller.dart';

import '../../home/add_details/controllers/add_details_controller.dart';
import '../../move/controllers/move_controller.dart';
import '../../move/offer_review/controllers/offer_review_controller.dart';
import '../../setting/controllers/setting_controller.dart';
import '../controllers/navbar_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(() => NavbarController());
    Get.lazyPut<AddDetailsController>(() => AddDetailsController());
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
    Get.lazyPut<MoveController>(() => MoveController());
    Get.lazyPut<OfferReviewController>(() => OfferReviewController());
    Get.lazyPut<MoverChatController>(() => MoverChatController());
    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
    // Get.lazyPut<AddDetailsController>(
    //       () => AddDetailsController(),
    // );
    Get.lazyPut<SettingController>(
            () => SettingController(),fenix: true
    );
    Get.lazyPut<MoveController>(
          () => MoveController(),
    );

  }
}
