import 'package:get/get.dart';

import '../../auth/create_account/controllers/create_account_controller.dart';
import '../../role_selection/controllers/role_selection_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<RoleSelectionController>(
          () => RoleSelectionController(),
    );
  }
}
