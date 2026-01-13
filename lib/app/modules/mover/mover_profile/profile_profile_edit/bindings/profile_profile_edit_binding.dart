import 'package:get/get.dart';

import '../controllers/profile_profile_edit_controller.dart';

class ProfileProfileEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileProfileEditController>(
      () => ProfileProfileEditController(),
    );
  }
}
