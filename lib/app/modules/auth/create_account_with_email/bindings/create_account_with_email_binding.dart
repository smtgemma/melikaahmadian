import 'package:get/get.dart';

import '../controllers/create_account_with_email_controller.dart';

class CreateAccountWithEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAccountWithEmailController>(
      () => CreateAccountWithEmailController(),
    );
  }
}
