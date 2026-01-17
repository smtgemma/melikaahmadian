import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/generated/assets.dart';
import '../controllers/custom_furniture_controller.dart';

class ProducCountity extends StatelessWidget {
  String? titel ;
  String? quantity ;
  bool? isReview ;
  String? reviewCount ;
   ProducCountity({super.key,this.isReview,this.reviewCount,this.titel,this.quantity});

  @override
  Widget build(BuildContext context) {
    //final controller =Get.find<>();
    final controller = Get.put(CustomFurnitureController());
    var textStyele = TextTheme.of(context);
    return Obx(() => Column(
      children: [
        ...List.generate(
          controller.addProduct.length,
              (index) {
            final item = controller.addProduct[index];

            return Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.onPrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                     // itemDecoration(child: Center(child: Image.asset(item.iconPath.toString()),),width: 54.w),
                      SizedBox(width: 8.w,),
                      /////////
                      Expanded(child: Text( item.titel.toString(),style: textStyele.bodyMedium!.copyWith(color: AppColors.secoundaryColor,fontWeight: FontWeight.bold),)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    itemDecoration(
                      child:
                    Row(
                      children: [
                        isReview == true ? SizedBox() : InkWell(
                           onTap: () {
                             if (controller.addProduct[index].count > 1) {
                               controller.addProduct[index].count--;
                               controller.addProduct.refresh();
                             }
                           },
                           child: itemDecoration(child: Image.asset(Assets.iconsMinize),color: AppColors.cardColor,hight: 40,width: 40)),
                        SizedBox(width: 8.w,),
                        Text( reviewCount ??  item.count.toString(),style: textStyele.bodyMedium!.copyWith(color: AppColors.secoundaryColor,fontWeight: FontWeight.bold),),
                        SizedBox(width: 8.w,),
                        isReview == true ? SizedBox() : InkWell(
                           onTap: () {
                             controller.addProduct[index].count++;
                             controller.addProduct.refresh();
                           },
                           child: itemDecoration(child: Image.asset(Assets.iconsAdd,height: 10,width: 10,),color: AppColors.cardColor)),
                      ],
                    ),),
                    SizedBox(width: 12.w,),
                    isReview == true ? SizedBox() : InkWell(onTap: (){
                      controller.addProduct.removeAt(index);
                    },child: itemDecoration(child:Image.asset(Assets.iconsDelete)))
                  ],),
                )




              ],),
            );
          },
        ),
      ],
    ));
    ;
  }
  Widget itemDecoration({Widget? child,double? width,double? horizontal ,double? vartical ,Color? color,double? hight }){
    return Container(
      width: width,
      height: hight,
      padding: EdgeInsets.symmetric(horizontal:horizontal ?? 11.w,vertical: vartical ?? 12.h),
      decoration: BoxDecoration(color: color ?? AppColors.primaryColor,borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }
}
