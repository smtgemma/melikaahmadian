import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/model/product_model.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/modules/home/custom_furniture/views/custom_furniture_view.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';
import '../../custom_furniture/controllers/custom_furniture_controller.dart';
import '../../custom_furniture/widget/produc_countity.dart';
import '../controllers/all_item_controller.dart';

class AllItemView extends GetView<AllItemController> {
  const AllItemView({super.key, this.type});
  final String? type;

  @override
  Widget build(BuildContext context) {
    Get.put(AllItemController());
    var textStyle = TextTheme.of(context);
    final furnitureController = Get.find<CustomFurnitureController>();

    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                AppBackButton(),
                SizedBox(height: 24.h),

                // Header
                Text(
                  type == 'ai'
                      ? "AI Analyzed Furnitures"
                      : "Selected Furniture's",
                  style: textStyle.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  type == 'ai'
                      ? "AI analyzed your video and detected these furnitures."
                      : "Review all the furniture's you added and proceed on last step.",
                  style: textStyle.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 20.h),

                // Products List
                ProductQuantityWidget(controller: furnitureController,),
                SizedBox(height: 20.h),

                // Add More Items Button
                AppButton(
                  containerColor: 1,
                  titel: "Add More Items",
                  onPress: () {
                    if (type == 'ai') {
                      _showAddItemDialog(context, furnitureController);
                    } else {
                      Get.to(CustomFurnitureView());
                    }
                  },
                  child: true,
                  iconPath: Assets.iconsAdd,
                ),
                SizedBox(height: 12.h),

                // Proceed Button
                Obx(
                  () => AppButton(
                    titel: furnitureController.selectedProducts.isEmpty
                        ? "Add Items to Proceed"
                        : "Proceed (${furnitureController.getTotalItemsCount()} items)",
                    onPress: furnitureController.selectedProducts.isEmpty
                        ? null
                        : () {
                            // controller.estimateCost();
                            Get.toNamed(Routes.AI_GENARED_PRICE);
                          },
                    isLoding: controller.isLoading.value,
                    bodycolor: furnitureController.selectedProducts.isEmpty
                        ? AppColors.cardColor
                        : AppColors.secoundaryColor,
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Show dialog to add item manually
  void _showAddItemDialog(
    BuildContext context,
    CustomFurnitureController furnitureController,
  ) {
    final itemNameController = TextEditingController();
    final quantityController = TextEditingController(text: "1");
    final RxInt quantity = 1.obs;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.w),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add New Item",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(Icons.close, size: 24),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Item Name Field
                  Text(
                    "Item Name",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: AppColors.secoundaryColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: itemNameController,
                    decoration: InputDecoration(
                      hintText: "Enter item name (e.g., Chair, Sofa)",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: BorderSide(
                          color: Colors.grey[300] ?? Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: BorderSide(
                          color: Colors.grey[300] ?? Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: BorderSide(
                          color: AppColors.secoundaryColor,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 14.h,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 20.h),

                  // Quantity Section
                  Text(
                    "Quantity",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: AppColors.secoundaryColor,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Quantity Controls
                  Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300] ?? Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: Row(
                        children: [
                          // Decrease Button
                          GestureDetector(
                            onTap: () {
                              if (quantity.value > 1) {
                                quantity.value--;
                              }
                            },
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.grey[300] ?? Colors.grey,
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: AppColors.secoundaryColor,
                              ),
                            ),
                          ),

                          // Quantity Display
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.h,
                              child: Text(
                                quantity.value.toString(),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secoundaryColor,
                                ),
                              ),
                            ),
                          ),

                          // Increase Button
                          GestureDetector(
                            onTap: () {
                              quantity.value++;
                            },
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.grey[300] ?? Colors.grey,
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: AppColors.secoundaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Action Buttons
                  Row(
                    children: [
                      // Cancel Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),

                      // Add Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final itemName = itemNameController.text.trim();

                            // Validation
                            if (itemName.isEmpty) {
                              Get.snackbar(
                                "Error",
                                "Please enter an item name",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return;
                            }

                            // Add item to selected products
                            furnitureController.toggleProduct(
                              ProductModel(
                                titel: itemName,
                                count: quantity.value,
                              ),
                            );

                            Get.back();

                            // Show success message
                            Get.snackbar(
                              "Success",
                              "$itemName added successfully!",
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              duration: Duration(seconds: 2),
                            );

                            // Clear fields
                            itemNameController.clear();
                            quantity.value = 1;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secoundaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                          child: Text(
                            "Add Item",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
