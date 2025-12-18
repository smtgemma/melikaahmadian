import 'package:get/get.dart';

import '../controllers/profile_tramd_condition_controller.dart';

class ProfileTramdConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileTramdConditionController>(
      () => ProfileTramdConditionController(),
    );
  }
}
