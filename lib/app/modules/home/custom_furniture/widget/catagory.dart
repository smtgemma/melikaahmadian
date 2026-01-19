import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import '../../add_details/controllers/add_details_controller.dart';
import '../controllers/custom_furniture_controller.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final furnitureController = Get.find<CustomFurnitureController>();
    final addDetailsController = Get.find<AddDetailsController>();
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 48.h,
      child: Obx(
            () {
          // Get appropriate category list based on house type
          final categoryList =
          furnitureController.getCategoryList(addDetailsController.selectedDateText.value);

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            separatorBuilder: (context, index) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final category = categoryList[index];
              final isSelected =
                  furnitureController.categoryIndex.value == index;

              return GestureDetector(
                  onTap: () async {
                    furnitureController.categoryIndex.value = index;
                    furnitureController.selectedCategory.value = category;

                    // Fetch furniture for selected category
                    final query = category.toLowerCase() == "all" ? "" : category;
                    await furnitureController
                        .getFurnitureByCategoryBackground(query);

                    debugPrint("Selected category: $category");
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.secoundaryColor
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.w),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.secoundaryColor
                            : AppColors.textSecoundaryColor,
                        width: 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                        BoxShadow(
                          color: AppColors.secoundaryColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.secoundaryColor,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  )
              );
            },
          );
        },
      ),
    );
  }
}