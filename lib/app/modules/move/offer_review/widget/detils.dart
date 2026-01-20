import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/move_video.dart';
import 'package:melikaahmadian/app/modules/move/offer_review/widget/single_information.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../../../home/custom_furniture/widget/produc_countity.dart';
import 'package:get/get.dart';

import '../controllers/offer_review_controller.dart';
import '../../../../core/widget/furniture_type.dart';
import '../repository/offer_review_repository.dart';

class Detils extends StatelessWidget {
  const Detils({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OfferReviewController>();
    var textStyele = TextTheme.of(context);
    // return Text("Detais data") ;
    return Expanded(
      child: Obx(() {
        var data = controller.detailsmodel.value.data ;
        if (controller.detailsLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.secoundaryColor),
          );
        }else if (data == null ) {
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(height: 200),
              Center(
                child: Text(
                  "No Offer",
                  style: textStyele.bodyLarge,
                ),
              ),
            ],
          );
        }
        return ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoveVideo(
                  videoPath: controller.detailsmodel.value.data?.media?[0].url ?? "",
                ),
                SizedBox(height: 24.h),
                Text("Location Details", style: textStyele.titleLarge),
                SizedBox(height: 12.h),
                Obx(
                  () => SingleInformation(
                    isChild: true,
                    titel:
                        controller
                            .detailsmodel
                            .value
                            .data
                            ?.pickupAddress
                            ?.address ??
                        "Toronto, Canada",
                  ),
                ),
                //picup
                SizedBox(height: 12.h),
                Container(
                  height: 145.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    color: Colors.grey,
                  ),
                  child: Obx(() {
                    final double lat = controller.detailsmodel.value.data?.pickupAddress?.latitude ?? 23.8103;
                    final double lng =controller.detailsmodel.value.data?.pickupAddress?.latitude ?? 90.4125;

                    return GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(lat, lng),
                        zoom: 15,
                      ),
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      markers: {
                        Marker(
                          markerId: const MarkerId("location"),
                          position: LatLng(lat, lng),
                          infoWindow:  InfoWindow(title: controller.detailsmodel.value.data?.pickupAddress?.address ?? ""),
                        ),
                      },
                    );
                  }),
                ),
                SizedBox(height: 12.h),
                Obx(
                  () => SingleInformation(
                    isChild: true,
                    titel:
                        controller
                            .detailsmodel
                            .value
                            .data
                            ?.dropoffAddress
                            ?.address ??
                        "Toronto, Canada",
                    iconPath: Assets.iconsFrom,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  height: 145.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    color: Colors.grey,
                  ),
                  child: Obx(() {
                    final double lat = controller.detailsmodel.value.data?.dropoffAddress?.latitude ?? 23.8103;
                    final double lng =controller.detailsmodel.value.data?.dropoffAddress?.latitude ?? 90.4125;

                    return GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(lat, lng),
                        zoom: 15,
                      ),
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      markers: {
                        Marker(
                          markerId: const MarkerId("location"),
                          position: LatLng(lat, lng),
                          infoWindow:  InfoWindow(title: controller.detailsmodel.value.data?.dropoffAddress?.address ?? ""),
                        ),
                      },
                    );
                  }),
                ),
                SizedBox(height: 24.h),
                Text("Time Details", style: textStyele.titleLarge),
                SizedBox(height: 12.h),
                Obx(() {
                  // Get the raw date string from API
                  String rawDate = controller.detailsmodel.value.data?.scheduleDate.toString() ?? "";

                  // Parse and format the date safely
                  String displayDate;

                  if (rawDate.isEmpty) {
                    displayDate = "27th November 2025"; // fallback
                  } else {
                    DateTime parsedDate = DateTime.parse(rawDate);
                    displayDate = DateFormat('dd MMM yyyy',).format(parsedDate); // e.g., 25 Dec 2024
                  }

                  return SingleInformation(
                    isChild: true,
                    titel: displayDate,
                    iconPath: Assets.iconsCalender,
                  );
                }),
                SizedBox(height: 12.h),
                //time
                Obx(
                  () => SingleInformation(
                    isChild: true,
                    titel:
                        controller.detailsmodel.value.data?.scheduleTime ??
                        "10:30 AM",
                    iconPath: Assets.iconsQuite,
                  ),
                ),
                SizedBox(height: 24.h),
                Text("Selected House Type", style: textStyele.titleLarge),
                SizedBox(height: 12.h),
                Obx(
                  () => SingleInformation(
                    titel: controller.detailsmodel.value.data?.houseType ?? "",
                  ),
                ),
                SizedBox(height: 24.h),
                Text("SSelected Furnitures", style: textStyele.titleLarge),
                SizedBox(height: 12.h),

                ...List.generate(
                  controller.detailsmodel.value.data?.furniture?.length ?? 0,
                  (index) {
                    final item =
                        controller.detailsmodel.value.data?.furniture?[index];

                    return FurnitureType(
                      titel: item?.name ?? "furniture",
                      quantity: item?.quantity.toString() ?? "1",
                    );
                  },
                ),
                AppButton(
                  titel: "Cancel Move",
                  onPress: () {
                    debugPrint("Cancel Move ${controller.detailsmodel.value.data?.id}");
                    bottomSheet(context,id: controller.detailsmodel.value.data?.id);
                  },
                ),
              ],
            );
          },
        );
      }),
    );
  }

  void bottomSheet(BuildContext context, {String? id}) {
    final controller = Get.find<OfferReviewController>();
    var textStyele = TextTheme.of(context);
    showModalBottomSheet(
      backgroundColor: AppColors.primaryColor,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SizedBox(
          height: 350, // 🔹 bottom sheet height
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              child: Obx(
                () => ListView(
                  children: List.generate(controller.cancelMove.length, (
                    index,
                  ) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 08),
                      child: AppButton(
                        titel: controller.cancelMove[index],
                        onPress: () {
                          Get.back();
                          OfferReviewRepository.canclMove(reason:controller.cancelMove[index],id: id );
                         // OfferReviewRepository
                        },
                        containerColor: 1,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
