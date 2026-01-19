import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';

import '../model/porfile_model.dart';
import '../model/review_model.dart';
import '../repository/mover_profile_repository.dart';

class MoverProfielDetailsController extends GetxController {
  //TODO: Implement MoverProfielDetailsController
  final isMore = true.obs ;
  final count = 0.obs;

  final profileLoading = false.obs;

  Rx<ProfileModel> profileModel = ProfileModel().obs ;
  Rx<ReviewModel> reviewmodel = ReviewModel().obs ;

  String? providerid ;
  String id = "69636e0c83df709e29a42015" ;


  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> argu = Get.arguments ?? {};
    providerid = argu[AppArgumentString.providrId] ?? '';
    debugPrint("profile controller oninit ${providerid}");
    getprofile(id: id) ;
    getReview(id: id);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<MoverProfielDetailsController>();
    super.onClose();
  }

  void increment() => count.value++;

  void more (){
    isMore.value = !isMore.value ;
  }
  Future<void> getprofile({String? id}) async {
    try {
      profileLoading.value = true;
      var response = await MoverProfileRepository.getDetails(id: id);
      profileModel.value = response;
    } catch (e) {
      profileLoading.value = false;
      debugPrint("profile controller catch Error: $e");

    }finally{
      profileLoading.value = false;
    }

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

  Future<void> refresh() async {
   await getprofile(id: id) ;
   await getReview(id: id) ;
  }

}
