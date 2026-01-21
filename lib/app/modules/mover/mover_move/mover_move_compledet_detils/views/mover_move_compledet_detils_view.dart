import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../../core/const/app_colors.dart';
import '../../../../../core/widget/app_back_button.dart';
import '../../../../move/offer_review/model/details_model.dart';
import '../../mover_move_detils/controllers/mover_move_detils_controller.dart';
import '../../mover_move_detils/widget/mover_move_detils.dart';
import '../controllers/mover_move_compledet_detils_controller.dart';

class MoverMoveCompledetDetilsView
    extends GetView<MoverMoveCompledetDetilsController> {
  const MoverMoveCompledetDetilsView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    final moverController = Get.put(MoverMoveDetilsController());
    final controller = Get.put(MoverMoveCompledetDetilsController());

    return Scaffold(
      body: RefreshIndicator(
        child: AppBackground(
          child: Obx(
            () => moverController.detailsLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secoundaryColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBackButton(),
                        SizedBox(height: 24.h),
                        Text(
                          "${controller.moveType} Move Details",
                          style: textStyele.titleLarge,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Details of a particular move.",
                          style: textStyele.bodyMedium,
                        ),
                        SizedBox(height: 24),
                        Obx(() {
                          String rawDate =
                              moverController
                                  .detailsmodel
                                  .value
                                  .data?[0]
                                  .createdAt
                                  .toString() ??
                              "";

                          // Parse and format the date safely
                          String displayDate;

                          if (rawDate.isEmpty) {
                            displayDate = "27th November 2025"; // fallback
                          } else {
                            DateTime parsedDate = DateTime.parse(rawDate);
                            displayDate = DateFormat(
                              'dd MMM yyyy',
                            ).format(parsedDate); // e.g., 25 Dec 2024
                          }

                          if (controller.detailsLoading.value == true) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.secoundaryColor,
                              ),
                            );
                          }
                          return MoverMoveDetils(
                            userId: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .provider
                                ?.id,
                            ProfileImage: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .provider
                                ?.image,
                            isCencel: true,
                            name:
                                moverController
                                    .detailsmodel
                                    .value
                                    .data?[0]
                                    .author
                                    ?.fullName
                                    .toString() ??
                                "",
                            ratring:
                                moverController
                                    .detailsmodel
                                    .value
                                    .data?[0]
                                    .author
                                    ?.averageRating
                                    ?.toStringAsFixed(1) ??
                                "0",
                            picAddress: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .postDetails
                                ?.pickupAddress
                                ?.address
                                .toString(),
                            dropAddress: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .postDetails
                                ?.dropoffAddress
                                ?.address
                                .toString(),
                            picLat: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .postDetails
                                ?.pickupAddress
                                ?.latitude,
                            picLong: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .postDetails
                                ?.pickupAddress
                                ?.longitude,
                            drolat: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .postDetails
                                ?.pickupAddress
                                ?.latitude,
                            drolong: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .postDetails
                                ?.dropoffAddress
                                ?.longitude,
                            data: displayDate,
                            time: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .postDetails
                                ?.scheduleTime
                                .toString(),
                            selectedType: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .postDetails
                                ?.houseType
                                .toString(),
                            listfurniture: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .postDetails
                                ?.furniture
                                ?.map(
                                  (e) => FurnitureModel(
                                    name: e.name.toString(),
                                    quantity: e.quantity!.toInt(),
                                  ),
                                )
                                .toList(),
                            postId: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .postId
                                .toString(),
                            videoPath: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .postMedia?[0]
                                .url
                                .toString(),
                            price: moverController
                                .detailsmodel
                                .value
                                .data?[0]
                                .offerPrice
                                .toString(),
                          );
                        }),
                      ],
                    ),
                  ),
          ),
        ),
        onRefresh: () {
          return moverController.getDetails(pram: controller.moveid);
        },
      ),
    );
  }
}
