import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../ongoing_mover_details/widget/onging_details.dart';
import '../controllers/cencel_mover_details_controller.dart';

class CencelMoverDetailsView extends GetView<CencelMoverDetailsController> {
  const CencelMoverDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: RefreshIndicator(child: AppBackground(child:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 24,),
            Text("Cencel Moves",style:textStyele.titleLarge,),
            SizedBox(height: 4.h,),
            Text("Details of Cencel moves & mover.",style: textStyele.bodyMedium,),
            SizedBox(height: 24,),
            Obx( () {

              String rawDate = controller.detailsmodel.value.data?.scheduleDate.toString() ?? "";

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
              }
                return OngingDetails(isCencel: true,name: controller.detailsmodel.value?.data?.acceptedOffer?.provider?.fullName.toString() ?? "" ,
                  ratring: controller.detailsmodel.value.data?.acceptedOffer?.provider?.averageRating.toStringAsFixed(1) ?? "0",
                  reviewRating: controller.detailsmodel.value.data?.acceptedOffer?.provider?.totalReviews.toStringAsFixed(0).toString() ?? "0",
                  picAddress: controller.detailsmodel.value.data?.pickupAddress?.address.toString(),
                  dropAddress: controller.detailsmodel.value.data?.dropoffAddress?.address.toString(),
                  picLat: controller.detailsmodel.value.data?.pickupAddress?.latitude,
                  picLong: controller.detailsmodel.value.data?.pickupAddress?.longitude,
                  drolat: controller.detailsmodel.value.data?.dropoffAddress?.latitude,
                  drolong: controller.detailsmodel.value.data?.dropoffAddress?.longitude,
                  data: displayDate,
                  time: controller.detailsmodel.value.data?.scheduleTime.toString(),
                  selectedType: controller.detailsmodel.value?.data?.houseType.toString(),
                  listfurniture: controller.detailsmodel.value?.data?.furniture,
                  postId: controller.detailsmodel.value?.data?.id.toString(),













                ) ;

            },)




          ],),
      )
        ,), onRefresh: (){
        return controller.getDetails(pram: controller.postId);
      }),
    );
  }
}
