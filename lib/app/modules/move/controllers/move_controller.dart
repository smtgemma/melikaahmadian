import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

import '../model/move_model.dart';
import '../repository/move_repository.dart';

class MoveController extends GetxController {

  late Future<void> initializeVideoPlayerFuture;
  final isLoading = false.obs;

  Rx<MoveModel> moveModel = MoveModel().obs;

  RxList moveitem = [
    "All Moves",
    "Ongoing",
    "Posted",
    "Completed",
    "Cancelled"
  ].obs;

  RxString selectedValue = "".obs;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getMoves();


  }

  @override
  void onClose() {

    super.onClose();
  }

  Future<void> getMoves({String? pram}) async {
    try {
      isLoading.value = true;
      moveModel.value = await MoveRepository.getMoves(pram: pram);
    } catch (e) {
      isLoading.value = false;
      debugPrint("moves controller Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

}