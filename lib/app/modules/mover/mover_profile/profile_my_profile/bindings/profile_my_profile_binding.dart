import 'package:get/get.dart';

import '../controllers/profile_my_profile_controller.dart';

class ProfileMyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileMyProfileController>(
      () => ProfileMyProfileController(),
    );
  }
}
