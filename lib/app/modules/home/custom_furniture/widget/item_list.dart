import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/model/product_model.dart';
import '../controllers/custom_furniture_controller.dart';
class ItemList extends StatelessWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomFurnitureController>();
    var textStyele = TextTheme.of(context);
    return  SizedBox(
          height: 400.h,
          child: Obx(() {

            return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1.4,  ),
              itemCount: controller.apiallItem.value.data?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var items = controller.apiallItem.value.data?[index];

                return  InkWell(
                  onTap: (){
                    // controller.toggleProduct(items?.name ?? "");
                    controller.toggleProduct(ProductModel(titel: items?.name,iconPath: items?.image,count: 0));

                    print("length is ${controller.apiallItem.value?.data?.length}");
                  },
                  child:Obx(() {
                    final isSelected = controller.addProduct.any((e) => e.titel == items?.name);
                    print(isSelected);
                    return  Container(
                        height: 50,
                        decoration: BoxDecoration(color: isSelected  ? AppColors.secoundaryColor :  AppColors.onPrimaryColor,borderRadius: BorderRadius.circular(12.w)),
                        child: Center(child: controller.furnitureLoading.value ? CircularProgressIndicator(color: AppColors.secoundaryColor,) :  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           (  items?.image == null) ? Text("loading....") :  Image.network(items?.image ?? "",color: isSelected ? AppColors.primaryColor : AppColors.secoundaryColor,),
                            SizedBox(height: 4.h,),
                            Text(items?.name ?? "",style: textStyele.bodyMedium!.copyWith(color: isSelected ? AppColors.primaryColor : AppColors.secoundaryColor),)
                          ],))
                    ) ;
                  },),
                );

              },);
          }));

  }
}
