import 'package:get/get.dart';

import '../controllers/mover_information_about_the_cancalation_controller.dart';

class MoverInformationAboutTheCancalationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverInformationAboutTheCancalationController>(
      () => MoverInformationAboutTheCancalationController(),
    );
  }
}
