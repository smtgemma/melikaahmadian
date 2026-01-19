import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../move/mover_profiel_details/model/review_model.dart';
import '../../../../move/mover_profiel_details/repository/mover_profile_repository.dart';
import '../../controllers/mover_profile_controller.dart';

class ProfileMyProfileController extends GetxController {
  //TODO: Implement ProfileMyProfileController
  final profileController = Get.find<MoverProfileController>();

  final nameTextEditingController = TextEditingController(text: "meskatul");
  final phoneTextEditingController = TextEditingController(text: "+880177777");
  final addressTextEditingController = TextEditingController(text: "Bangladesh");
  final emailTextEditingController = TextEditingController(text: "m*******@gmail.com");

  Rx<ReviewModel> reviewmodel = ReviewModel().obs ;
  final profileLoading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getReview(id: profileController.profileModel.value.data?.id);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  Future<void> refresh() async {
    debugPrint("profile controller refresh ${profileController.profileModel.value.data?.id}");
    await getReview(id: profileController.profileModel.value.data?.id);
  }



  Future<void> getReview({String? id}) async {
    try {
      profileLoading.value = true;
      var response = await MoverProfileRepository.getReview(id: id);
      reviewmodel.value = response;
    } catch (e) {
      profileLoading.value = false;
      debugPrint("profile controller catch Error: $e");

    }finally{
      profileLoading.value = false;
    }

  }
}
