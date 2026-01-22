import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/modules/home/custom_furniture/widget/catagory.dart';
import 'package:melikaahmadian/app/modules/home/custom_furniture/widget/item_list.dart';
import 'package:melikaahmadian/app/modules/home/custom_furniture/widget/produc_countity.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import '../controllers/custom_furniture_controller.dart';

class CustomFurnitureView extends GetView<CustomFurnitureController> {
  const CustomFurnitureView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(CustomFurnitureController());
    controller.getCategoryList('');
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  AppBackButton(),
                  SizedBox(height: 20.h),

                  // Header section
                  Text(
                    "Furniture's List",
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Select furniture you want to add to your move",
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Category section
                  _buildSectionTitle(
                    textTheme,
                    "Categories",
                    controller.furnitureLoading.value
                        ? "${controller.furnitureModel.value.data?.length ?? 0} items"
                        : "Select a category",
                  ),
                  SizedBox(height: 12.h),
                  CategoryWidget(),
                  SizedBox(height: 20.h),

                  // Items section
                  _buildSectionTitle(
                    textTheme,
                    "Available Items",
                    controller.selectedProducts.isEmpty
                        ? "No items selected"
                        : "${controller.selectedProducts.length} selected",
                  ),
                  SizedBox(height: 12.h),
                  ItemListWidget(),
                  SizedBox(height: 24.h),

                  // Selected items quantity section
                  Obx(
                    () => controller.selectedProducts.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle(
                                textTheme,
                                "Selected Items",
                                "Adjust quantities below",
                              ),
                              SizedBox(height: 12.h),
                              ProductQuantityWidget(controller: controller,),
                              SizedBox(height: 20.h),
                            ],
                          )
                        : SizedBox.shrink(),
                  ),

                  // Proceed button
                  _buildProceedButton(),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    TextTheme textTheme,
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 2.h),
        Text(
          subtitle,
          style: textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
        ),
      ],
    );
  }

  Widget _buildProceedButton() {
    return Obx(
      () => AppButton(
        titel: controller.selectedProducts.isEmpty
            ? "Select Items to Proceed"
            : "Proceed (${controller.getTotalItemsCount()} items)",
        onPress: controller.selectedProducts.isEmpty
            ? null
            : () {
                Get.toNamed(Routes.ALL_ITEM);
              },
        bodycolor: controller.selectedProducts.isEmpty
            ? AppColors.cardColor
            : AppColors.secoundaryColor,
      ),
    );
  }
}
