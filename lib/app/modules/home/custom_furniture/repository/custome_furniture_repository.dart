import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';

import '../../../../core/const/app_urls.dart';
import '../controllers/custom_furniture_controller.dart';
import '../model/get_furniture_model.dart';

class CustomeFurnitureRepository {
  static final controller = Get.put(CustomFurnitureController());

  static Future<GetFurnitureModel> getFurnitureByCatagory(
    String catagory,
  ) async {
    try {
      controller.furnitureLoading.value = true;
      String Url;
      if (catagory == "" || catagory.isEmpty || catagory == null) {
        Url = AppUrls.getFurnitureByCatagory;
      } else {
        Url = AppUrls.getFurnitureByCatagory + "?category=$catagory";
      }

      final response = await DioClient().get(Url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        controller.furnitureLoading.value = false;
        // controller.apiAllItem.value.;
        if (response.data['data'] != null) {
          controller.apiallItem.value = GetFurnitureModel.fromJson(
            response.data,
          );
          print('data length is ${controller.apiallItem.value.data?.length}');
          // controller.apiallItem.value = response.data['data']
          //     .map<GetFurnitureModel>((json) => GetFurnitureModel.fromJson(json))
          //     .toList();
        }
        return GetFurnitureModel.fromJson(response.data);
      } else {
        controller.furnitureLoading.value = false;
        debugPrint(response.data['message']);
        return GetFurnitureModel();
      }
    } on DioError catch (e) {
      controller.furnitureLoading.value = false;
      // throw Exception(e.response?.data['message']);
      debugPrint(e.response?.data['message']);
      debugPrint(e.response?.statusCode.toString());
      return GetFurnitureModel();
    }
  }
}
