import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/all_post_model.dart';
import '../../mover_location_city/repository/mover_searse_post_repositoy.dart';
import '../../mover_search_post/controllers/mover_search_post_controller.dart';

class MoverSerchedLocationedController extends GetxController {
  //TODO: Implement MoverSerchedLocationedController
  final serschedController = Get.find<MoverSearchPostController>();

  RxBool isLoading = false.obs;

  /// ✅ This will store ONLY POSTED items
  Rx<AllPostModel> moverHomeModel = AllPostModel(data: []).obs;
  RxList<PostData> postItems = <PostData>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    seaarchMoves(pickupState: serschedController.picstate.value,dropoffState: serschedController.dropstate.value,pickupCity: serschedController.picacity.value,dropoffCity:serschedController.dropcity.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> seaarchMoves({String? pickupState, String? dropoffState, String? pickupCity, String? dropoffCity}) async {
    try {
      isLoading.value = true;

      final result = await MoverSearsePostRepositoy.searchAddress(dropoffCity:dropoffCity ,dropoffState:dropoffState ,pickupCity:pickupCity ,pickupState: pickupState);
      moverHomeModel.value = result;


      postItems.clear(); // important for refresh

      for (var element in result.data ?? []) {
        if (element.status == "POSTED") {
          postItems.add(element);
        }
      }

      print("Total from API: ${result.data?.length}");
      print("Posted only: ${postItems.length}");
    } catch (e) {
      debugPrint("moves controller Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
