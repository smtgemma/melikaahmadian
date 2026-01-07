import 'package:get/get.dart';

import '../../home/add_details/controllers/add_details_controller.dart';
import '../../setting/controllers/setting_controller.dart';
import '../controllers/navbar_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
    Get.lazyPut<AddDetailsController>(
      () => AddDetailsController(),
    );
    Get.lazyPut<SettingController>(
            () => SettingController(),fenix: true
    );
  }
}
