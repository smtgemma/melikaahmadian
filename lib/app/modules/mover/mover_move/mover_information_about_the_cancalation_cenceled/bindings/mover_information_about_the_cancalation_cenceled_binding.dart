import 'package:get/get.dart';

import '../controllers/mover_information_about_the_cancalation_cenceled_controller.dart';

class MoverInformationAboutTheCancalationCenceledBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoverInformationAboutTheCancalationCenceledController>(
      () => MoverInformationAboutTheCancalationCenceledController(),
    );
  }
}
