import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../controllers/mover_location_city_controller.dart';

class MoverLocationCityView extends GetView<MoverLocationCityController> {
  const MoverLocationCityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Expanded(child: ListView.builder(
        itemCount: 10,

        itemBuilder: (context, index) {
          var textStyele = TextTheme.of(context);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Get.toNamed(Routes.MOVER_SERCHED_LOCATIONED);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bangladesh",style: textStyele.bodyMedium,),
                  SizedBox(height: 04.h,),
                  Divider()
              
                ],
              ),
            ),
          );

      },)),
    );
  }
}
