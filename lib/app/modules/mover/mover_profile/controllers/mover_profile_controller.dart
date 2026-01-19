import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../move/mover_profiel_details/repository/mover_profile_repository.dart';
import '../model/mover_profile_model.dart';
import '../repository/mover_profile_repository.dart';

class MoverProfileController extends GetxController {
  //TODO: Implement MoverProfileController
  Rx<MoverProfileModel> profileModel = MoverProfileModel().obs ;
  final isLoading = false.obs ;
  // late TextEditingController nameTextEditingController;
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();

  RxList<String> selectedSpecialties = <String>[].obs;
  RxList<String> vehicleImages = <String>[].obs;






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
      vehicleImages.clear() ;
      isLoading.value = true ;
      final data = await MoverProfileRepositorys.getProfile();
      profileModel.value = data ;
      nameTextEditingController.text = profileModel.value.data?.fullName ?? "";
      emailTextEditingController.text = profileModel.value.data?.email ?? "";
      selectedSpecialties.value = profileModel.value.data?.specialization ?? [];
     // vehicleImages.value = profileModel.value.data?.providerDocuments?.map((e) => e.url ?? "").toList() ?? [];
     for(var item in profileModel.value.data?.providerDocuments ?? []){
       if(item.name == "Vehicle Photo"){
         vehicleImages.add(item.url ?? "");
       }


     }

      isLoading.value = false ;
      debugPrint("get profile controll ${vehicleImages.length}");




    }catch(e){
      isLoading.value = false ;
      debugPrint("get profile controll catch error ${e}");
    }finally{
      isLoading.value = false ;
    }
  }


}
