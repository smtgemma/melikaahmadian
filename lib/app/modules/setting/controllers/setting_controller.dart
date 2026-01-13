import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/modules/setting/model/get_profile_model.dart';

import '../repository/setting_reository.dart';

class SettingController extends GetxController {
  //TODO: Implement SettingController
  Rx<GetProfileModel> profileModel = GetProfileModel().obs ;

  final isLoading = false.obs ;


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

   Future getProfile()async{
    try{
      isLoading.value = true ;
      final data = await SettingReository.getProfile() ;
      profileModel.value = data ;

    }catch(e){
      isLoading.value = false ;
      debugPrint("get profile controll catch error ${e}");
    }finally{
      isLoading.value = false ;
    }
   }
}
