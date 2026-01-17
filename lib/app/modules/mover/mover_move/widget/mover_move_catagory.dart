import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';

import '../controllers/mover_move_controller.dart';


class MoverMoveCatagory extends StatelessWidget {
  const MoverMoveCatagory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MoverMoveController>();
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
                  if(controller.selectedValue.value == "Offer"){
                   controller.getMoves();
                  }else if(controller.selectedValue.value == "Pending"){
                    controller.getMoves(pram: "PENDING");
                  }else if(controller.selectedValue.value == "Accepted"){
                    controller.getMoves(pram: "ACCEPTED");
                  }else if(controller.selectedValue.value == "Rejected"){
                    controller.getMoves(pram: "REJECTED");
                  }else if(controller.selectedValue.value == "Cancelled"){
                      controller.getMoves(pram: "CANCELLED");
                  }else if(controller.selectedValue.value == "Compeletd"){
                      controller.getMoves(pram: "COMPLETED");
                  }
                }),),

          );

        },),

      ),
    );
  }
}
