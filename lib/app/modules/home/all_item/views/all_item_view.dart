import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../../../core/widget/App_button.dart';
import '../../custom_furniture/repository/custome_furniture_repository.dart';
import '../../custom_furniture/widget/produc_countity.dart';
import '../controllers/all_item_controller.dart';

class AllItemView extends GetView<AllItemController> {
  const AllItemView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 24.h,),
              Text("AI Analyzed Furnitures",style: textStyele.titleLarge,),
              SizedBox(height: 4.h,),
              Text("AI analyzed your video and detected these furnitures.",),
              SizedBox(height: 12.h,),
              ProductQuantityWidget(),
              SizedBox(height: 12.h,),
              AppButton(containerColor: 1,titel: "Add More Items",onPress: (){Get.toNamed(Routes.CUSTOM_FURNITURE);},child: true,iconPath: Assets.iconsAdd,),
              SizedBox(height: 12.h,),
              AppButton(titel: "Proceed",onPress: (){
                Get.toNamed(Routes.AI_GENARED_PRICE);

              })

          
            ],
          ),
        ),
      ),

    );
  }
}
