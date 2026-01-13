import 'package:get/get.dart';

import '../controllers/document_uplod_page_controller.dart';

class DocumentUplodPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentUplodPageController>(
      () => DocumentUplodPageController(),
    );
  }
}
