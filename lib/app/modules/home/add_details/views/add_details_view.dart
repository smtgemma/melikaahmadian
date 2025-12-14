import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../controllers/add_details_controller.dart';

class AddDetailsView extends GetView<AddDetailsController> {
  const AddDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 24.h,),
              Text("Pickup & Drop-off",style: textStyele.titleLarge,),
              SizedBox(height: 4.h,),
              Text("Where should we move your items?",style: textStyele.bodyMedium,),
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(12.w)),
          
              ),
              SizedBox(height: 24.h,),
              Text("Address Details ",style: textStyele.titleLarge,),
              SizedBox(height: 144.h,),
              Text("Time Details",style: textStyele.titleLarge,),
              SizedBox(height: 12.h,),
              TextField(
                controller: controller.dataEditingController,
                readOnly: true,
                onTap: (){
                  controller.selectDate(context);
                },
                decoration: InputDecoration(
                  hintText: "Select date",
                  prefixIcon: Icon(Icons.calendar_month_outlined)
                ),
              ),
              SizedBox(height: 12.h,),
              TextField(
                controller: controller.timeEditingController,
                readOnly: true,
                onTap: (){
                  controller.timeSelectDate(context);
                },
                decoration: InputDecoration(
                    hintText: "Select date",
                    prefixIcon: Icon(Icons.access_time_outlined)
                ),
              ),
              SizedBox(height: 24.h,),
              Text("House Type Selection",style: textStyele.titleLarge,),
              Obx(() => SizedBox(
                height: 280,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 2,
                  children: List.generate(controller.houseType.length, (index) {
                    var data = controller.houseType[index] ;
                    return InkWell(
                      onTap: (){
                        controller.selectedHouseType.value = index;
                        controller.selectedDateText.value = data.titel.toString() ;

                        debugPrint(controller.selectedDateText.value);
                      },
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(color: controller.selectedHouseType.value == index ?AppColors.secoundaryColor :  AppColors.onPrimaryColor,borderRadius: BorderRadius.circular(12.w)),
                          child: Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(data.iconPath.toString(),color: controller.selectedHouseType.value == index ? AppColors.primaryColor : AppColors.secoundaryColor,),
                              SizedBox(height: 4.h,),
                              Text(data.titel.toString(),style: textStyele.bodyMedium!.copyWith(color: controller.selectedHouseType.value == index ? AppColors.primaryColor : AppColors.secoundaryColor),)
                            ],))
                      ),
                    );
                  }),
                ),
              ),),
              AppButton(titel: 'Select Your Items',onPress: (){
                Get.toNamed(Routes.CUSTOM_FURNITURE);
              },),
              SizedBox(height: 24.h,)




            ],
          ),
        ),
      ),
    );
  }
}
