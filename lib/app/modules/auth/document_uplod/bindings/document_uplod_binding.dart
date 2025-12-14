import 'package:get/get.dart';

import '../controllers/document_uplod_controller.dart';

class DocumentUplodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentUplodController>(
      () => DocumentUplodController(),
    );
  }
}
