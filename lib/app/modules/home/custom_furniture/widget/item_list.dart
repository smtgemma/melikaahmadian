import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/model/product_model.dart';
import '../controllers/custom_furniture_controller.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomFurnitureController>();
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 420.h,
      child: Obx(
            () {
          final items = controller.furnitureModel.value.data;

          // Loading state
          if (controller.furnitureLoading.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.secoundaryColor,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text("Loading furniture items..."),
                ],
              ),
            );
          }

          // Empty state
          if (items == null || items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "No items available",
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Try selecting a different category",
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          // Grid view with items
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.85,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildItemCard(context, controller, item, textTheme);
            },
          );
        },
      ),
    );
  }

  Widget _buildItemCard(
      BuildContext context,
      CustomFurnitureController controller,
      dynamic item,
      TextTheme textTheme,
      ) {
    return Obx(
          () {
        final isSelected = controller.isProductSelected(item.name);

        return GestureDetector(
            onTap: () {
              controller.toggleProduct(
                ProductModel(
                  titel: item.name,
                  iconPath: item.image,
                  count: 1,
                ),
              );
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color:
                isSelected ? AppColors.secoundaryColor : AppColors.onPrimaryColor,
                borderRadius: BorderRadius.circular(12.w),
                border: Border.all(
                  color: isSelected
                      ? AppColors.secoundaryColor
                      : Colors.grey[300] ?? Colors.grey,
                  width: isSelected ? 2 : 1,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image with loading and error handling
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: _buildItemImage(item.image, isSelected),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Item name
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      item.name ?? "Unknown",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.secoundaryColor,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Selection indicator
                  if (isSelected)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                        child: Icon(
                          Icons.check,
                          size: 16,
                          color: AppColors.secoundaryColor,
                        ),
                      ),
                    ),
                ],
              ),
            )
        );
      },
    );
  }

  Widget _buildItemImage(String? imageUrl, bool isSelected) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Colors.grey[400],
          size: 32,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.contain,
      color: isSelected ? AppColors.primaryColor : AppColors.secoundaryColor,
      colorBlendMode: BlendMode.srcIn,
      placeholder: (context, url) => Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.secoundaryColor,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.broken_image_outlined,
        color: Colors.grey[400],
        size: 32,
      ),
    );
  }
}