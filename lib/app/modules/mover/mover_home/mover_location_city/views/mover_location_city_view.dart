import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../mover_search_post/controllers/mover_search_post_controller.dart';
import '../controllers/mover_location_city_controller.dart';

class MoverLocationCityView extends GetView<MoverLocationCityController> {
  const MoverLocationCityView({super.key});
  @override
  Widget build(BuildContext context) {
    final  moverSerce = Get.find<MoverSearchPostController>() ;
    return Scaffold(

      body: RefreshIndicator(child:  AppBackground(
        child:  Obx(() => controller.isLoading == true ? Center(child: CircularProgressIndicator(color: AppColors.secoundaryColor,),) :
         ListView(
           children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 AppBackButton(),
                 ListView.builder(
                   shrinkWrap: true,
                   itemCount: controller.postItems.value.data?.length ?? 0,

                   itemBuilder: (context, index) {
                     var textStyele = TextTheme.of(context);

                     final data  = controller.postItems.value.data?[index];

                     return Padding(
                       padding: EdgeInsets.only(bottom: 5.h),
                       child: InkWell(
                         onTap: (){
                           if(controller.isType == true){
                             moverSerce.picacity.value = data?.city ?? "";
                             moverSerce.picstate.value = data?.state ?? "";
                             moverSerce.pickupController.text = data?.city ?? "";
                             Get.back() ;

                           }else{
                             moverSerce.dropcity.value = data?.city ?? "";
                             moverSerce.dropstate.value = data?.state ?? "";
                             moverSerce.dropoffController.text = data?.city ?? "";
                             Get.back();

                           }
                          // Get.toNamed(Routes.MOVER_SERCHED_LOCATIONED);
                         },
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                            ListTile(
                              title: Text(data?.city ?? "",style: textStyele.titleLarge!.copyWith(fontWeight: FontWeight.bold,fontSize: 16)),
                              subtitle:  Text(data?.state ?? "",style: textStyele.bodyMedium!.copyWith(fontWeight: FontWeight.bold,fontSize: 12)),

                            ),
                            // SizedBox(height: 04.h,),
                             Divider()

                           ],
                         ),
                       ),
                     );

                   },)
               ],
             )
           ],
         )

          ,),
      ), onRefresh: () async {
        await controller.getAddress();
      }),
    );
  }
}
