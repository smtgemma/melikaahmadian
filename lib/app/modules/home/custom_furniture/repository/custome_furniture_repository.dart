import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';

import '../../../../core/const/app_urls.dart';
import '../controllers/custom_furniture_controller.dart';
import '../model/get_furniture_model.dart';

class CustomeFurnitureRepository {
  static final controller = Get.find<CustomFurnitureController>();

  static Future<GetFurnitureModel> getFurnitureByCatagory(String catagory) async {
    try {
      String url = catagory.isEmpty
          ? AppUrls.getFurnitureByCatagory
          : "${AppUrls.getFurnitureByCatagory}?category=$catagory";

      final response = await DioClient().get(url);

      if (response.statusCode == 200) {
        return GetFurnitureModel.fromJson(response.data);
      }
      return GetFurnitureModel();
    } catch (e) {
      return GetFurnitureModel();
    }
  }

}
