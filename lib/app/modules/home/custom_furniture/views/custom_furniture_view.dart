import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import '../../../../core/const/app_colors.dart';
import '../controllers/custom_furniture_controller.dart';
import '../widget/catagory.dart';
import '../widget/item_list.dart';

class CustomFurnitureView extends GetView<CustomFurnitureController> {
  const CustomFurnitureView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 24.h,),
            Text("Furniture's List",style: textStyele.titleLarge,),
            SizedBox(height: 4.h,),
            Text("Select a furniture you want to add in your move.",style: textStyele.bodyMedium,),
            Catagory(),
            SizedBox(height: 12.h,),
            ItemList()

          ],
        ),
      ),),
    );
  }
}
