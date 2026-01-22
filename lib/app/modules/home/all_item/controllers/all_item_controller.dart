import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../ai_genared_price/controllers/ai_genared_price_controller.dart';
import '../../ai_genared_price/views/ai_genared_price_view.dart';
import '../model/all_item_model.dart';
import '../repository/all_item_repository.dart';

class AllItemController extends GetxController {
  // This controller is minimal as most logic is in CustomFurnitureController
  // You can add specific logic for AllItemView here if needed in the future
  final aicontroller = Get.put(AiGenaredPriceController());


  Rx<AllItemModel> allItemModel = AllItemModel().obs;
  RxBool isLoading = false.obs;



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> estimateCost() async {
    try{
      isLoading.value = true;
      final response = await AllItemRepository.estimateCost();
      allItemModel.value = response;
      aicontroller.price.value = response.totalCost.toString();
      isLoading.value = false;
    //  Get.toNamed(Routes.AI_GENARED_PRICE,);
      Get.to( AiGenaredPriceView(type: "ai",));


    }catch(e){
      debugPrint("ai error $e");

    }finally{
      isLoading.value = false;

    }

  }
}