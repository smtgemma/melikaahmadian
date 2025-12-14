import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';

import '../../add_details/controllers/add_details_controller.dart';
import '../controllers/custom_furniture_controller.dart';

class Catagory extends StatelessWidget {
   Catagory({super.key});
  final controller = Get.find<CustomFurnitureController>();
  final addItemController = Get.find<AddDetailsController>();
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return SizedBox(
        height: 40.h,
        child:  ListView.builder(
          itemCount: addItemController.selectedDateText.value == "Commercial" ? controller.commersialCatagory.length : controller.catagory.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var data =  addItemController.selectedDateText.value == "Commercial" ? controller.commersialCatagory[index] : controller.catagory[index] ;
            return GestureDetector(
              onTap: (){
                controller.catagoryIndex.value = index ;
                controller.selectedCatagory.value = data ;
                debugPrint(controller.selectedCatagory.value);
              },
              child: Padding(
                padding:  EdgeInsets.only(right: 10),
                child: Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                  decoration: BoxDecoration(color: controller.catagoryIndex.value == index ?AppColors.secoundaryColor :  AppColors.primaryColor,borderRadius: BorderRadius.circular(8.w),border: Border.all(color: AppColors.textSecoundaryColor,width: 2)),
                  child: Text(data,style: textStyele.bodyMedium!.copyWith(color:controller.catagoryIndex.value == index ? AppColors.primaryColor : AppColors.secoundaryColor ,fontWeight: FontWeight.bold ),),
                ),),
              ),
            );

          },),
    );
  }
}
