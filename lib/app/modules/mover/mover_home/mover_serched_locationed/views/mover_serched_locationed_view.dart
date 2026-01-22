import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/widget/move_status_video.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../core/const/app_colors.dart';
import '../../../../../core/widget/mover_move_video_status.dart';
import '../../mover_search_post/controllers/mover_search_post_controller.dart';
import '../controllers/mover_serched_locationed_controller.dart';

class MoverSerchedLocationedView
    extends GetView<MoverSerchedLocationedController> {
  const MoverSerchedLocationedView({super.key});
  @override
  Widget build(BuildContext context) {
    final serschedController = Get.find<MoverSearchPostController>();
    var textStyele = TextTheme.of(context);
    return Scaffold(
     body: RefreshIndicator(child:ListView(
       children: [
         AppBackground(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               AppBackButton(),
               //
               SizedBox(height: 24.h,),
               Container(
                 padding: EdgeInsets.all(16),
                 decoration: BoxDecoration(color: AppColors.secoundaryColor,borderRadius: BorderRadius.circular(12)),
                 child: Column(
                   children: [
                     ListTile(
                       leading: Container(
                         padding: EdgeInsets.all(12),
                         decoration: BoxDecoration(color: AppColors.primaryColor,shape: BoxShape.circle),
                         child: Image.asset(Assets.iconsFlash),
                       ),
                       title: Text("12",style: textStyele.titleMedium!.copyWith(color: AppColors.primaryColor)),
                       subtitle: Text("New move post in your selected area.",style: textStyele.bodyMedium!.copyWith(color: AppColors.primaryColor),),


                     ),

                   ],
                 ),

               ),
               SizedBox(height: 24.h,),
               Obx(() {
                 if (controller.isLoading.value) {
                   return Center(
                     child: CircularProgressIndicator(
                       color: AppColors.secoundaryColor,
                     ),
                   );
                 }

                 final data = controller.postItems;

                 if (data.isEmpty) {
                   return Center(
                     child: Text(
                       "No Moves Found",
                       style: textStyele.titleMedium,
                     ),
                   );
                 }

                 return ListView.builder(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemCount: controller.moverHomeModel.value.data?.length ?? 0,
                   itemBuilder: (context, index) {
                     final item = controller.moverHomeModel.value.data![index];

                     String formattedDate = (item.createdAt ?? "").split("T").first;

                     //return Text(item.media?[0]?.url ?? "");

                     return Padding(
                       padding: const EdgeInsets.only(bottom: 10),
                       child: Column(
                         children: [
                           MoverMoveStatusVideo(
                             isOffer: true,
                             postId: item.id,
                             videoUrl: item.media?[0]?.url ?? "",
                             from: item.dropoffAddress?.address ?? "",
                             to: item.pickupAddress?.address ?? "",
                             date: formattedDate,
                             isNavigator: true,
                             titel:  "Offer",
                             // color: _statusBgColor(item.status),
                             //textColor: _statusTextColor(item.status),
                             isType: item.status ?? "",
                           ),
                         ],
                       ),
                     );
                   },
                 );
               })
             ],
           ),
         )
       ],
     ), onRefresh: (){return controller.seaarchMoves(pickupState: serschedController.picstate.value,dropoffState: serschedController.dropstate.value,pickupCity: serschedController.picacity.value,dropoffCity:serschedController.dropcity.value);
     }),
    );
  }
}
