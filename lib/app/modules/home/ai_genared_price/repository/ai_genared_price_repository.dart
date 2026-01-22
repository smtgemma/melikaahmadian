import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:intl/intl.dart';
import '../../../../core/const/app_argument_string.dart';
import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../routes/app_pages.dart';
import '../../add_details/controllers/add_details_controller.dart';
import '../../custom_furniture/controllers/custom_furniture_controller.dart';
import '../../video_cmera/controllers/video_cmera_controller.dart';
import '../controllers/ai_genared_price_controller.dart';
import '../model/mopst_request_model.dart';

class AiGenaredPriceRepository {
  static final priceController = Get.put(AiGenaredPriceController());
  static final customFurnitureController = Get.put(CustomFurnitureController());
  static final addDeatilsController = Get.put(AddDetailsController());
  static final videoCameraController = Get.put(VideoCmeraController());

  static Future<void> postMoves() async {
    try {
      priceController.isLoading.value = true;

      final parsedDate = DateFormat('dd MMM yyyy').parse(
        addDeatilsController.dataEditingController.text,
      );
      final isoDate = parsedDate.toUtc().toIso8601String(); // This will add 'Z' at the end

      // ✅ FIX 2: Extract actual text from TextEditingController
      final scheduleTime = addDeatilsController.timeEditingController.text.trim();

      debugPrint("📅 Schedule Date (ISO): $isoDate");
      debugPrint("⏰ Schedule Time: $scheduleTime");

      // ✅ Convert ProductModel → Furniture with logging
      final List<Furniture> furnitureList = customFurnitureController.selectedProducts
          .map((product) {
        final num qty = (product.count < 1)
            ? 1
            : product.count;
        debugPrint("🪑 Furniture: ${product.titel}, fixed qty: $qty");
        return Furniture(name: product.titel, quantity: qty);
      })
          .toList();

      // ✅ Create Request Model
      postRequestModel model = postRequestModel(
        offerPrice: int.parse(priceController.price.value),
        houseType: addDeatilsController.selectedDateText.value,
        scheduleDate: isoDate, // ✅ Now includes 'Z'
        scheduleTime: scheduleTime, // ✅ Now just the text string
        pickupAddress: PickupAddress(
          address: addDeatilsController.picupAddress.value,
          latitude: double.parse(addDeatilsController.picupLatitude.value),
          longitude: double.parse(addDeatilsController.picupLongitude.value),
        ),
        dropoffAddress: PickupAddress(
          address: addDeatilsController.dropAddress.value,
          latitude: double.parse(addDeatilsController.dropLatitude.value),
          longitude: double.parse(addDeatilsController.dropLongitude.value),
        ),
        furniture: furnitureList,
      );

      // ✅ Log full request JSON
      final requestJson = model.toJson();
      debugPrint("📦 Full Request JSON: ${jsonEncode(requestJson)}");

      // ✅ FormData with video file
      FormData formData = FormData.fromMap({
        "data": jsonEncode(model.toJson()),
        "media": await MultipartFile.fromFile(
          videoCameraController.videoPath.value,
          filename: "video.mp4",
        ),
      });

      debugPrint("➡️ Sending POST request to: ${AppUrls.post}");
      debugPrint("📁 Video Path: ${videoCameraController.videoPath.value}");
      debugPrint(
        "📝 FormData keys: ${formData.fields.map((f) => f.key).toList()}",
      );

      // ✅ Send API
      var response = await DioClient().post(AppUrls.post, data: formData);

      // ✅ Log response
      debugPrint("📤 Response Status: ${response.statusCode}");
      debugPrint("📤 Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        priceController.isLoading.value = false;
        Get.snackbar("Success", "Uplod Successfully");
        Get.toNamed(Routes.APPLICATION_SUBMIT,arguments: {AppArgumentString.mover: AppArgumentString.mover});
        debugPrint("✅ Success");
      } else {
        priceController.isLoading.value = false;
        Get.snackbar("Error", "Something Went Wrong");
        debugPrint("❌ Error: Status ${response.statusCode}");
      }
    } on DioError catch (e) {
      priceController.isLoading.value = false;
      debugPrint("⚠️ API Error: ${e.response?.statusCode}");
      debugPrint("⚠️ API Error Data: ${e.response?.data}");
      Get.snackbar("Error", "Something Went Wrong");
      debugPrint("⚠️ API Error Message: ${e.message}");
    } catch (e) {
      priceController.isLoading.value = false;
      debugPrint("⚠️ Unknown Error: $e");
    }
  }
}