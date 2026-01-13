import 'package:get/get.dart';
import 'package:melikaahmadian/app/modules/mover/mover_move/mover_move_detils/model/status_model.dart';

class MoverMoveDetilsController extends GetxController {
  //TODO: Implement MoverMoveDetilsController

  RxList<StatusModel> status = [
    StatusModel(statusString: "On The Way To The Pickup Location",sttus: 1,statusStatus: true),
    StatusModel(statusString: "Reached The Pickup Location",sttus: 0,statusStatus: false),
    StatusModel(statusString: "On The way To Dropoff Location",sttus: 0,statusStatus: false),
    StatusModel(statusString: "Reached The Dropoff Location",sttus: 0,statusStatus: false),
    StatusModel(statusString: "Mark As completed Move",sttus: 0,statusStatus: false),
  ].obs ;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
