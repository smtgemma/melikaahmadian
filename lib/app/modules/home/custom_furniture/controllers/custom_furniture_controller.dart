import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/model/product_model.dart';
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
  RxList<ProductModel> selectedProducts = <ProductModel>[
    ProductModel(titel: "wfwfw",count: 3)
  ].obs;
  Rx<GetFurnitureModel> furnitureModel = GetFurnitureModel().obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint("🎯 CustomFurnitureController initialized");
    selectedCategory.value = "All";
    _initializeFurnitureData();
  }

  // ✅ FIXED: No isolate needed - just call repository directly
  Future<void> _initializeFurnitureData() async {
    debugPrint("📊 Initializing furniture data...");
    await getFurnitureByCategoryBackground("");
  }

  /// ✅ FIXED: Simple async method without isolate
  /// API calls work fine on main thread with proper error handling
  Future<void> getFurnitureByCategoryBackground(String category) async {
    try {
      furnitureLoading.value = true;
      debugPrint("🔄 Fetching furniture: '$category'");

      // Call repository directly - it handles auth and errors
      final result = await CustomeFurnitureRepository.getFurnitureByCatagory(
        category,
      );

      furnitureModel.value = result;
      debugPrint("✅ Successfully fetched ${result.data?.length ?? 0} items");

      furnitureLoading.value = false;
    } catch (e) {
      furnitureLoading.value = false;
      debugPrint("❌ Error loading furniture: $e");

      // Show user-friendly error
      Get.snackbar(
        "Error",
        "Failed to load furniture. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
    debugPrint("🛑 CustomFurnitureController closed");
    super.onClose();
  }
}
