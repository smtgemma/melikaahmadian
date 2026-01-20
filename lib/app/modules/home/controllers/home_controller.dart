import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../mover/mover_home/model/all_post_model.dart';
import '../../mover/mover_home/repository/mover_home_repositroy.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxString videoType = "".obs ;

  Rx<AllPostModel> moverHomeModel = AllPostModel(data: []).obs;
  RxBool isLoading = false.obs;
  RxList<PostData> postItems = <PostData>[].obs;

  @override
  void onInit() {
    super.onInit();
  }
  Future<void> getMoves() async {
    try {
      isLoading.value = true;

      final result = await MoverHomeRepositroy.getMoves();
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
