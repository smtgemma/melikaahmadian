import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/const/app_colors.dart';
import '../../../../../core/widget/app_back_button.dart';
import '../../../../../core/widget/app_background.dart';
import '../../../../move/offer_review/controllers/offer_review_controller.dart';
import '../../../../move/offer_review/model/details_model.dart';
import '../../../../move/offer_review/widget/move_offer_details.dart';
import '../../../../move/ongoing_mover_details/widget/onging_details.dart';
import '../../../../move/ongoing_mover_details/widget/onging_move_update.dart';
import '../controllers/mover_move_detils_controller.dart';
import '../widget/mover_move_detils.dart';
import '../widget/update_status.dart';

class MoverMoveDetilsView extends GetView<MoverMoveDetilsController> {
  const MoverMoveDetilsView({super.key});
  @override
  Widget build(BuildContext context) {
    final offercontroller = Get.put(OfferReviewController());
    final moverController = Get.put(MoverMoveDetilsController());
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body:  RefreshIndicator(child: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 24,),
              Text("Accepted Move Details",style:textStyele.titleLarge,),
              SizedBox(height: 4.h,),
              Text("Details of a particular move.",style: textStyele.bodyMedium,),
              Text("Details of a particular move." + controller.postId.toString(),style: textStyele.bodyMedium,),

              SizedBox(height: 24.h,),
              MoveOfferDetails(offer: "Update Status",details: "Details",isMover: true,),
              SizedBox(height: 24.h,),
              Obx(() =>  (offercontroller.selectedOfferDetails.value == "Update Status" ||
                  offercontroller.selectedOfferDetails.value == "offer")  ? UpdateStatus() :
              Obx( () {

                String rawDate = moverController.detailsmodel.value.data?[0].createdAt.toString() ?? "";

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
                return MoverMoveDetils(isCencel: true,name: moverController.detailsmodel.value?.data?[0]?.author?.fullName.toString() ?? "" ,
                  ratring: moverController.detailsmodel.value?.data?[0]?.author?.averageRating?.toStringAsFixed(1) ?? "0",
                  picAddress: moverController.detailsmodel.value.data?[0].postDetails?.pickupAddress?.address.toString(),
                  dropAddress: moverController.detailsmodel.value.data?[0].postDetails?.dropoffAddress?.address.toString(),
                  picLat: moverController.detailsmodel.value.data?[0].postDetails?.pickupAddress?.latitude,
                  picLong: moverController.detailsmodel.value.data?[0].postDetails?.pickupAddress?.longitude,
                  drolat: moverController.detailsmodel.value.data?[0].postDetails?.pickupAddress?.latitude,
                  drolong: moverController.detailsmodel.value.data?[0].postDetails?.dropoffAddress?.longitude,
                  data: displayDate,
                  time: moverController.detailsmodel.value.data?[0].postDetails?.scheduleTime.toString(),
                  selectedType: moverController.detailsmodel.value.data?[0].postDetails?.houseType.toString(),
                  listfurniture: moverController.detailsmodel.value.data?[0].postDetails?.furniture
                      ?.map((e) => FurnitureModel(name: e.name.toString(), quantity: e.quantity!.toInt()))
                      .toList(),
                  postId: moverController.detailsmodel.value.data?[0].postId.toString(),
                  videoPath: moverController.detailsmodel.value.data?[0].postMedia?[0].url.toString(),
                  price: moverController.detailsmodel.value.data?[0].offerPrice.toString(),
                  isRequestButton: true,

                ) ;

              },) )
            ],

          ),
        ),
      ), onRefresh: (){
        return moverController.refresh();
      }),
    );
  }
}
