import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';

class MoverMoveCompledetDetilsController extends GetxController {
  //TODO: Implement MoverMoveCompledetDetilsController
  String moveType = "";
  String moveid = "";
  RxBool detailsLoading = false.obs;


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    final argu = Get.arguments;
    moveType = argu?[AppArgumentString.moverStatus];
    moveid = argu?[AppArgumentString.postId];


  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


}
