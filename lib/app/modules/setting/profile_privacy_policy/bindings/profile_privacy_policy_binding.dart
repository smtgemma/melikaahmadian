import 'package:get/get.dart';

import '../controllers/profile_privacy_policy_controller.dart';

class ProfilePrivacyPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePrivacyPolicyController>(
      () => ProfilePrivacyPolicyController(),
    );
  }
}
