import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../move/model/move_model.dart';
import '../../../move/repository/move_repository.dart';

class CencelRequestController extends GetxController {
  //TODO: Implement CencelRequestController

  final count = 0.obs;
  Rx<MoveModel> moveModel = MoveModel().obs;
  final isLoading = false.obs;

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

  Future<void> getMoves() async {
    try {
      isLoading.value = true;
      moveModel.value = await MoveRepository.getMoves(pram: "CANCELLED");
    } catch (e) {
      isLoading.value = false;
      debugPrint("moves controller Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
