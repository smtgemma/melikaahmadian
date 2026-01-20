import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/model/product_model.dart';
import '../../../../../generated/assets.dart';
import '../model/get_furniture_model.dart';
import '../repository/custome_furniture_repository.dart';

class CustomFurnitureController extends GetxController {
  // Category lists
  RxList<String> category = <String>[
    "All",
    "Drawing Room",
    "Bed Room",
    "Dining Room",
    "Kitchen",
    "Washroom",
  ].obs;

  RxList<String> commercialCategory = <String>[
    "Restaurant",
    "Bakery",
    "Factory",
  ].obs;

  RxList<String> moverCategory = <String>[
    "Ongoing",
    "All Moves",
    "Posted",
    "Completed",
    "Cancelled",
  ].obs;

  RxList<String> moverMoveCategory = <String>[
    "Offered",
    "Ongoing",
    "Completed",
    "Cancelled",
  ].obs;

  // State management
  RxBool furnitureLoading = false.obs;
  RxInt categoryIndex = 0.obs;
  RxString selectedCategory = "".obs;
  RxList<ProductModel> selectedProducts = <ProductModel>[].obs;
  Rx<GetFurnitureModel> furnitureModel = GetFurnitureModel().obs;

  // Isolate ports for communication
  ReceivePort? _receivePort;
  Isolate? _isolate;

  @override
  void onInit() {
    super.onInit();
    debugPrint("🎯 CustomFurnitureController initialized");
    selectedCategory.value = "All";
    _initializeFurnitureData();
  }

  Future<void> _initializeFurnitureData() async {
    debugPrint("📊 Initializing furniture data...");
    await getFurnitureByCategoryBackground("");
  }

  /// Fetch furniture using isolate for background processing
  /// ✅ SAFE: No UI calls, all logic in isolate
  Future<void> getFurnitureByCategoryBackground(String category) async {
    try {
      furnitureLoading.value = true;
      debugPrint("🔄 [ISOLATE START] Fetching: '$category'");

      final receivePort = ReceivePort();

      // Spawn isolate
      _isolate = await Isolate.spawn(
        _furnitureIsolate,
        _IsolateParams(sendPort: receivePort.sendPort, category: category),
      );

      // Listen for result (one-time only)
      receivePort.listen(
        (message) {
          if (message is GetFurnitureModel) {
            debugPrint(
              "✅ [ISOLATE DONE] Got ${message.data?.length ?? 0} items",
            );
            furnitureModel.value = message;
            furnitureLoading.value = false;
            receivePort.close();
          } else if (message is String) {
            // Error message from isolate
            debugPrint("❌ [ISOLATE ERROR] $message");
            furnitureLoading.value = false;

            // Handle specific errors
            if (message.contains("401")) {
              // Don't handle auth here - let main thread handle it
              Get.snackbar(
                "Session Expired",
                "Please login again",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            } else {
              Get.snackbar(
                "Error",
                "Failed to load furniture",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
            receivePort.close();
          }
        },
        onError: (error) {
          debugPrint("❌ [ISOLATE LISTEN ERROR] $error");
          furnitureLoading.value = false;
          receivePort.close();
        },
      );
    } catch (e) {
      furnitureLoading.value = false;
      debugPrint("❌ Error spawning isolate: $e");
      Get.snackbar(
        "Error",
        "Failed to load furniture",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Static method to run in isolate
  /// ✅ IMPORTANT: NO UI code here (no Get, no BuildContext, etc.)
  static Future<void> _furnitureIsolate(_IsolateParams params) async {
    try {
      debugPrint("🔄 [ISOLATE WORKER] Started");

      // Call repository (this will make the API call)
      final result = await CustomeFurnitureRepository.getFurnitureByCatagory(
        params.category,
      );

      debugPrint("🔄 [ISOLATE WORKER] Got result, sending back");

      // Send result back to main thread
      params.sendPort.send(result);
    } catch (e) {
      debugPrint("❌ [ISOLATE WORKER ERROR] $e");

      // Send error message back to main thread
      params.sendPort.send(e.toString());
    }
  }

  /// Get current category items based on selection
  List<String> getCategoryList(String houseType) {
    if (houseType == "Commercial") {
      return commercialCategory.toList();
    } else if (houseType == "mover") {
      return moverCategory.toList();
    } else if (houseType == "mover_move") {
      return moverMoveCategory.toList();
    }
    return category.toList();
  }

  /// Toggle product selection
  void toggleProduct(ProductModel product) {
    final exists = selectedProducts.any(
      (p) => p.titel?.toLowerCase() == product.titel?.toLowerCase(),
    );

    if (exists) {
      selectedProducts.removeWhere(
        (p) => p.titel?.toLowerCase() == product.titel?.toLowerCase(),
      );
      debugPrint("❌ Removed: ${product.titel}");
    } else {
      selectedProducts.add(product);
      debugPrint("✅ Added: ${product.titel}");
    }
    debugPrint("📊 Total selected: ${selectedProducts.length}");
  }

  /// Check if product is selected
  bool isProductSelected(String? productName) {
    return selectedProducts.any(
      (p) => p.titel?.toLowerCase() == productName?.toLowerCase(),
    );
  }

  /// Update product quantity
  void updateProductQuantity(int index, int newQuantity) {
    if (index >= 0 && index < selectedProducts.length && newQuantity > 0) {
      selectedProducts[index].count = newQuantity;
      selectedProducts.refresh();
      debugPrint("🔄 Updated qty at index $index to $newQuantity");
    }
  }

  /// Remove product from selection
  void removeProduct(int index) {
    if (index >= 0 && index < selectedProducts.length) {
      final removed = selectedProducts[index].titel;
      selectedProducts.removeAt(index);
      debugPrint("🗑️ Removed: $removed");
    }
  }

  /// Clear all selections
  void clearAllProducts() {
    selectedProducts.clear();
    debugPrint("🗑️ Cleared all products");
  }

  /// Get total items selected
  int getTotalItemsCount() {
    return selectedProducts.fold(0, (sum, item) => sum + (item.count ?? 0));
  }

  /// Reset category selection
  void resetCategorySelection() {
    categoryIndex.value = 0;
    selectedCategory.value = "All";
    debugPrint("🔄 Reset category selection");
  }

  @override
  void onClose() {
    // Kill isolate if still running
    _isolate?.kill(priority: Isolate.immediate);
    _receivePort?.close();

    debugPrint("🛑 CustomFurnitureController closed");
    super.onClose();
  }
}

/// Parameters passed to isolate
class _IsolateParams {
  final SendPort sendPort;
  final String category;

  _IsolateParams({required this.sendPort, required this.category});
}
