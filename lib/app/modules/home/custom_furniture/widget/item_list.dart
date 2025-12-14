import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/const/app_colors.dart';
import '../controllers/custom_furniture_controller.dart';
class ItemList extends StatelessWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomFurnitureController>();
    var textStyele = TextTheme.of(context);
    return  SizedBox(height: 600.h,
          child: Obx(() => GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 1.4,  ),
            itemCount: controller.selectedCatagory.value == "Washroom" ? controller.washroom.length:
            controller.selectedCatagory.value == "Drawing Room" ? controller.drawingRoom.length :
            controller.selectedCatagory.value == "Bed Room" ? controller.bed_room.length :
            controller.selectedCatagory.value == "Dining Room" ? controller.dining_room.length :
            controller.selectedCatagory.value == "Kitchen" ? controller.kitcen.length : controller.allItem.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              print(controller.allItem.length);
              var data ;
              controller.selectedCatagory.value == "Washroom" ? data = controller.washroom[index] :
              controller.selectedCatagory.value == "Drawing Room" ? data = controller.drawingRoom[index] :
              controller.selectedCatagory.value == "Bed Room" ? data = controller.bed_room[index] :
              controller.selectedCatagory.value == "Dining Room" ? data = controller.dining_room[index] :
              controller.selectedCatagory.value == "Kitchen" ? data = controller.kitcen[index] : data = controller.allItem[index] ;
              return  Container(
                  height: 50,
                  decoration: BoxDecoration(color: controller.itemIndex.value == index ?AppColors.secoundaryColor :  AppColors.onPrimaryColor,borderRadius: BorderRadius.circular(12.w)),
                  child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(data.iconPath.toString(),color: controller.itemIndex.value == index ? AppColors.primaryColor : AppColors.secoundaryColor,),
                      SizedBox(height: 4.h,),
                      Text(data.titel.toString(),style: textStyele.bodyMedium!.copyWith(color: controller.itemIndex.value == index ? AppColors.primaryColor : AppColors.secoundaryColor),)
                    ],))
              );

            },)));

  }
}
