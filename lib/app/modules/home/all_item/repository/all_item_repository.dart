import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../add_details/controllers/add_details_controller.dart';
import '../../custom_furniture/controllers/custom_furniture_controller.dart';
import '../model/all_item_model.dart';

class AllItemRepository {
 static final controller = Get.find<CustomFurnitureController>();
 static final addcontroller = Get.find<AddDetailsController>();


 static Future<AllItemModel> estimateCost() async {
   try {
     final dio = Dio();

     List<Map<String, dynamic>> itemsList =
     controller.selectedProducts.map((product) {
       return {
         "name": product.titel,
         "quantity": product.count,
         "size": product.size,
         "category": product.category,
       };
     }).toList();

     final body = {
       "items": itemsList,
       "total_volume_cubic_feet": addcontroller.totalVolume.value,
       "distance_km": addcontroller.distance.value,
      // "move_date": addcontroller.selectedDateText.value,
       "move_date": "28 Nov 2026",
     };

     final response = await dio.post(
       "http://72.60.126.182:3033/api/v1/estimate-cost",
       data: body,
       options: Options(headers: {
         "Content-Type": "application/json",
       }),
     );

     print("✅ Response: ${response.data}");

     return AllItemModel.fromJson(response.data); // ✅ MUST return
   } catch (e) {
     print("❌ Error: $e");
     rethrow; // ✅ keeps return type safe
   }
 }



}