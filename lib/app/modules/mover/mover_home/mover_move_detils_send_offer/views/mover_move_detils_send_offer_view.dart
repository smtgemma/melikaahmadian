import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../controllers/mover_move_detils_send_offer_controller.dart';
import '../widget/mover_detils.dart';

class MoverMoveDetilsSendOfferView
    extends GetView<MoverMoveDetilsSendOfferController> {
  const MoverMoveDetilsSendOfferView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: RefreshIndicator(child: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 24.h,),
              Text("Move Details",style: textStyele.titleLarge,),
              Text("Move Details ${controller.postId}",style: textStyele.titleLarge,),
              SizedBox(height: 4.h,),
              Text("Details of a particular move.",style: textStyele.bodyMedium,),
              Obx(() {
                String rawDate = controller.detailsmodel.value.data?.createdAt.toString() ?? "";

                // Parse and format the date safely
                String displayDate;

                if (rawDate.isEmpty) {
                  displayDate = "27th November 2025"; // fallback
                } else {
                  DateTime parsedDate = DateTime.parse(rawDate);
                  displayDate = DateFormat('dd MMM yyyy',).format(parsedDate); // e.g., 25 Dec 2024
                }
                if(controller.detailsLoading.value == true){
                  return Center(child: CircularProgressIndicator(color: AppColors.secoundaryColor,),);
                }else{
                  return  MoverDetils(videoPath: controller.detailsmodel.value.data?.media[0].url ?? "",
                    picAddress:  controller.detailsmodel.value.data?.pickupAddress?.address ?? "",
                    dropAddress: controller.detailsmodel.value.data?.dropoffAddress?.address ?? "",
                    picLat: controller.detailsmodel.value.data?.pickupAddress?.latitude ?? 0,
                    picLong: controller.detailsmodel.value.data?.pickupAddress?.longitude ?? 0,
                    drolat: controller.detailsmodel.value.data?.dropoffAddress?.latitude ?? 0,
                    drolong: controller.detailsmodel.value.data?.dropoffAddress?.longitude ?? 0,
                    data: displayDate,
                    time: controller.detailsmodel.value.data?.scheduleTime ?? "",
                    selectedType: controller.detailsmodel.value.data?.houseType ?? "",
                    listfurniture: controller.detailsmodel.value.data?.furniture ?? [],
                    postId: controller.detailsmodel.value.data?.id ?? "",


                  );
                }

              },),
              SizedBox(height: 12.h,),
            ],
          ),
        ),
      ), onRefresh: (){
        return controller.getDetails(pram: controller.postId);
      }),
    );
  }
}
