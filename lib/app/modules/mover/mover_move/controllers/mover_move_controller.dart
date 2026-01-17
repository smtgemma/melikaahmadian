import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../move/model/move_model.dart';
import '../Repository/mover_move_repository.dart';
import '../model/mover_move_model.dart';

class MoverMoveController extends GetxController {
  //TODO: Implement MoverMoveController

  RxList moveitem  = [ "Offer","Pending","Accepted","Rejected","Cancelled","Compeletd"].obs;
  RxString selectedValue = "".obs ;
  RxInt selectedIndex = 0.obs ;
  final isLoading = false.obs;

  Rx<MoverMoveModel> moveModel = MoverMoveModel().obs;
  @override
  void onInit() {
    super.onInit();
    getMoves();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  Future<void> getMoves({String? pram}) async {
    try {
      isLoading.value = true;
      moveModel.value = await MoverMoveRepository.getMoves(pram: pram);
    } catch (e) {
      isLoading.value = false;
      debugPrint("moves controller Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


}
