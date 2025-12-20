import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../../../../core/widget/app_back_button.dart';
import '../controllers/mover_search_post_controller.dart';

class MoverSearchPostView extends GetView<MoverSearchPostController> {
   MoverSearchPostView({super.key});
   final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

   @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBackButton(),
          SizedBox(height: 24.h,),
          Text("Search Posted Move By Location ",style: textStyele.titleLarge,),
          SizedBox(height: 4.h,),
          Text("Enter the locations to see the job posts.",style: textStyele.bodyMedium,),
          SizedBox(height: 24.h,),
          Form(
            key: _globalKey,
              child: Column(children: [
                SizedBox(
                  height: 52,
                  child: TextFormField(
                    // validator: (value){
                    //   if(value!.isEmpty){
                    //     return "Enter pickup address";
                    //   }
                    // },
                    cursorHeight: 20.h,
                    controller: controller.pickupController,
                    decoration: InputDecoration(
                      hintText: "Enter pickup address",
                     prefixIcon: Image.asset(Assets.iconsTo),

                    ),

                  ),
                ),
                SizedBox(height: 12.h,),
                SizedBox(
                  height: 52,
                  child: TextFormField(
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Enter Drop-off address";
                    //   }
                    //   return null;
                    // },
                    controller: controller.dropoffController,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Enter Drop-off address",
                      prefixIcon: Image.asset(
                        Assets.iconsFrom,
                      ),
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 24.h,),
                AppButton(titel: "Search Moves",onPress: (){
                  if(_globalKey.currentState!.validate()){
                    Get.toNamed(Routes.MOVER_LOCATION_CITY);

                  }
                },)



              ],))

        ],
      ),),
    );
  }
}
