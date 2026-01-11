import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';

import '../controllers/move_controller.dart';
import '../repository/move_repository.dart';

class MoveCatagory extends StatelessWidget {
  const MoveCatagory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MoveController>();
    var textStyele = TextTheme.of(context);
    return SizedBox(
      height: 40.h,
      child:Obx(() =>  ListView.builder(
        itemCount: controller.moveitem.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding:  EdgeInsets.only(left: 10),
            child: Obx(() => ChoiceChip(
                label: Text(controller.moveitem[index],style: textStyele.bodyLarge!.copyWith(color:  controller.selectedIndex == index
                ? Colors.white     // ✅ Selected text color
                    : Colors.black,),),
                showCheckmark: false,

                backgroundColor: AppColors.primaryColor,
                selectedColor: AppColors.secoundaryColor, selected: controller.selectedIndex.value == index,
                onSelected: (value) {
                  controller.selectedIndex.value = index;
                  controller.selectedValue.value = controller.moveitem[index];
                  debugPrint(controller.selectedValue.value);
                  if(controller.selectedValue.value == "All Moves"){
                    controller.getMoves();
                  }else if(controller.selectedValue.value == "Ongoing"){
                    controller.getMoves(pram: "ONGOING");
                  }else if(controller.selectedValue.value == "Posted"){
                    controller.getMoves(pram: "POSTED");
                  }else if(controller.selectedValue.value == "Completed"){
                    controller.getMoves(pram: "COMPLETED");
                  }else if(controller.selectedValue.value == "Cancelled"){
                    controller.getMoves(pram: "CANCELLED");
                  }
                }),),

          );

        },),

      ),
    );
  }
}
