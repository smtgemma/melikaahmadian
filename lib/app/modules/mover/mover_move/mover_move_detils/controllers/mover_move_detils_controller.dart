import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/modules/mover/mover_move/mover_move_detils/model/status_model.dart';

import '../../../../../core/const/app_argument_string.dart';
import '../../../../../core/network/shared_prepharence_helper.dart';
import '../../../../move/offer_review/model/details_model.dart';
import '../../../../move/offer_review/repository/offer_review_repository.dart';
import '../../Repository/mover_move_repository.dart';

import '../../model/mover_move_details.dart';
import '../../model/status_model.dart';
import '../rpository/mover_move_repository.dart';

class MoverMoveDetilsController extends GetxController {
  //TODO: Implement MoverMoveDetilsController

  final detailsLoading = false.obs;


  // RxList<StatusModel> status = [
  //   StatusModel(statusString: "On The Way To The Pickup Location",sttus: 1,statusStatus: true),
  //   StatusModel(statusString: "Reached The Pickup Location",sttus: 0,statusStatus: false),
  //   StatusModel(statusString: "On The way To Dropoff Location",sttus: 0,statusStatus: false),
  //   StatusModel(statusString: "Reached The Dropoff Location",sttus: 0,statusStatus: false),
  //   StatusModel(statusString: "Mark As completed Move",sttus: 0,statusStatus: false),
  // ].obs ;

  List<String> uiStatus = [
    "On The Way To The Pickup Location",
    "Reached The Pickup Location",
    "On The way To Dropoff Location",
    "Reached The Dropoff Location",
    "Mark As completed Move",
  ];

 List<String> uploadeStatus = [
    "NOT_STARTED",
    "ON_WAY_TO_PICKUP",
    "REACHED_PICKUP",
    "ON_WAY_TO_DROPOFF",
    "REACHED_DROPOFF",
  ] ;
 List<String> cancelStatus = [
    "Unexpected Personal Emergency",
    "Client’s Problem",
    "Vehicle Breakdown",
    "Wrong address added",
    "Wrong item video",
  ] ;



  Rx<MoverMoveDetailsModel> detailsmodel = MoverMoveDetailsModel().obs ;
  Rx<MoverStatusModel> statusmodel = MoverStatusModel().obs ;
  String? postId ;

  @override
  void onInit() {
     super.onInit();
    // final args = Get.arguments;
    //
    // postId = args?[AppArgumentString.postId];


  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  Future<void> refresh ()async{
    postId = SharedPrefHelper.getString(SharedPrefHelper.postId);

    getDetails(pram: postId);
    getStatus(pram: postId);
  }


  Future<void> getDetails({String? pram}) async {
    try {
      detailsLoading.value = true;
      var response = await MoverMoveDetailsRepository.getDetails(pram: pram);
      detailsmodel.value = response;
    } catch (e) {
      detailsLoading.value = false;
      debugPrint("offer controller catch Error: $e");

    }finally{
      detailsLoading.value = false;
    }

  }

  Future<void> getStatus({String? pram}) async {
    try {
      detailsLoading.value = true;
      var response = await MoverMoveDetailsRepository.getStatus(pram: pram);
      statusmodel.value = response;
    } catch (e) {
      detailsLoading.value = false;
      debugPrint("offer controller catch Error: $e");

    }finally{
      detailsLoading.value = false;
    }

  }
}
