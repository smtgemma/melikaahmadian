import 'package:get/get.dart';

import '../controllers/set_new_password_controller.dart';

class SetNewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetNewPasswordController>(
      () => SetNewPasswordController(),
    );
  }
}
