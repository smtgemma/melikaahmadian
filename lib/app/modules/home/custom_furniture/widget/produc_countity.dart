import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/generated/assets.dart';
import '../controllers/custom_furniture_controller.dart';

class ProductQuantityWidget extends StatelessWidget {
  final bool isReview;
  final String? reviewCountText;

  const ProductQuantityWidget({
    super.key,
    this.isReview = false,
    this.reviewCountText,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomFurnitureController>();
    final textTheme = Theme.of(context).textTheme;

    return Obx(
          () => Column(
        children: [
          // Empty state
          if (controller.selectedProducts.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Text(
                  "No items selected",
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),

          // List of selected products
          ...List.generate(
            controller.selectedProducts.length,
                (index) {
              final item = controller.selectedProducts[index];

              return _buildProductTile(
                context,
                controller,
                item,
                index,
                textTheme,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductTile(
      BuildContext context,
      CustomFurnitureController controller,
      dynamic item,
      int index,
      TextTheme textTheme,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.onPrimaryColor,
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(
          color: AppColors.secoundaryColor.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product name
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.titel?.toString() ?? "Unknown",
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.secoundaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Quantity controls
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Decrease button
                if (!isReview)
                  _buildQuantityButton(
                    icon: Assets.iconsMinize,
                    onTap: () {
                      if ((item.count ?? 0) > 1) {
                        item.count = (item.count ?? 1) - 1;
                        controller.selectedProducts.refresh();
                      }
                    },
                  ),

                SizedBox(width: 8.w),

                // Quantity display
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(6.w),
                  ),
                  child: Text(
                    reviewCountText ?? item.count.toString(),
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.secoundaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(width: 8.w),

                // Increase button
                if (!isReview)
                  _buildQuantityButton(
                    icon: Assets.iconsAdd,
                    onTap: () {
                      item.count = (item.count ?? 0) + 1;
                      controller.selectedProducts.refresh();
                    },
                  ),

                SizedBox(width: 12.w),

                // Delete button
                if (!isReview)
                  GestureDetector(
                    onTap: () {
                      _showDeleteConfirmation(context, controller, index);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.w),
                      ),
                      child: Image.asset(
                        Assets.iconsDelete,
                        height: 20.h,
                        width: 20.w,
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(6.w),
          border: Border.all(
            color: AppColors.secoundaryColor.withOpacity(0.2),
          ),
        ),
        child: Image.asset(
          icon,
          height: 18.h,
          width: 18.w,
          color: AppColors.secoundaryColor,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context,
      CustomFurnitureController controller,
      int index,
      ) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.delete_outline, size: 40, color: Colors.red),
              SizedBox(height: 12.h),
              Text(
                "Remove Item?",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Are you sure you want to remove this item?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.removeProduct(index);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}