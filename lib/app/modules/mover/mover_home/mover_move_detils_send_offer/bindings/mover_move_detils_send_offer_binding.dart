import 'package:get/get.dart';

import '../controllers/mover_move_detils_send_offer_controller.dart';

class MoverMoveDetilsSendOfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverMoveDetilsSendOfferController>(
      () => MoverMoveDetilsSendOfferController(),
    );
  }
}
