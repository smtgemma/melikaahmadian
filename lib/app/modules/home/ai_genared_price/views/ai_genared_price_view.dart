import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/app_back_button.dart';
import '../../../../core/widget/app_background.dart';
import '../controllers/ai_genared_price_controller.dart';
import '../repository/ai_genared_price_repository.dart';

class AiGenaredPriceView extends GetView<AiGenaredPriceController> {
  String ? type ;
   AiGenaredPriceView({super.key,this.type});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AiGenaredPriceController());
    var textStyele = TextTheme.of(context);
    return Scaffold(
        body: AppBackground(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBackButton(),
                SizedBox(height: 24.  h,),
                Text(type == "ai" ? "AI Analyzed Price" : "Write Your Own Price",style: textStyele.titleLarge,),
                SizedBox(height: 4.h,),
                Text( type == "ai" ? "AI analyzed your video and generated a price." : "This price will go to the movers and then can send you custom counter offers.",),
                SizedBox(height: 12.h,),
              //textfield
                type == "ai" ? SizedBox() :  Container(
                height: 52.h,
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.cardColor,borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Container(
                      height: double.infinity,
                      width: 54.w,
                      decoration: BoxDecoration(color: AppColors.secoundaryColor,borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r),bottomLeft: Radius.circular(12.r))),
                      child: Center(child: Text("\$",style: textStyele.headlineLarge!.copyWith(color: AppColors.primaryColor),),)),
                    Expanded(
                      child: TextField(
                        controller: controller.priceTextEditignControoler,
                        keyboardType: TextInputType.number,
                        cursorColor: AppColors.secoundaryColor,
                        cursorHeight: 20.h,
                        decoration: const InputDecoration(
                          hintText: "Write your offer price",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    )
                    
                  ],
                ),
              ),
                SizedBox(height: 24.h,),
               //price box
               Stack(children: [
                 Container(
                   height: 150.h,
                   width: double.infinity,
                   decoration: BoxDecoration(color: AppColors.secoundaryColor,borderRadius: BorderRadius.circular(12)),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text( type == "ai" ? "Estimated Price" : "Write Down Your Estimated Price",style: textStyele!.titleLarge!.copyWith(color: AppColors.primaryColor),),
                       SizedBox(height: 4.h,),
                       Obx(() => Text("\$${controller.price.value}",style: textStyele!.headlineLarge!.copyWith(color: AppColors.primaryColor),),),
                       SizedBox(height: 12.h,),
                       Text( type == "ai" ? "Based on AI. It’s not perfect " : "",style: textStyele!.titleLarge!.copyWith(color: AppColors.dartRed),),


                     ],
                   ),
                 ),
                 Positioned(
                   top: -40,
                   left: -40,
                   child: Container(
                     height: 123.h,
                     width: 123.w,
                     decoration: BoxDecoration(color: AppColors.shadoColor.withAlpha(10),shape: BoxShape.circle),
                   ),
                 ),
                 Positioned(
                   bottom: -60,
                   right: -60,
                   child: Container(
                     height: 123.h,
                     width: 123.w,
                     decoration: BoxDecoration(color: AppColors.shadoColor.withAlpha(10),shape: BoxShape.circle),
                   ),
                 )
               ],),
                SizedBox(height: 24.h,),
               Obx(() =>  AppButton(titel: type == "ai" ? "Back To Home" : "Post Move",onPress: (){
                 if(type == "ai"){
                   Get.toNamed(Routes.NAVBAR);
                 }else{
                   AiGenaredPriceRepository.postMoves();
                 }

                 //
               },isLoding: controller.isLoading.value,),),
                SizedBox(height: 12.h,),
                type == "ai" ? SizedBox() :  AppButton(containerColor: 1,titel: "Edit Details",
                  onPress: (){Get.toNamed(Routes.CUSTOM_FURNITURE);},),




              ],
            ),
          ),
        ),);
  }
}
