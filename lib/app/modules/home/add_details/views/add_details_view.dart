import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/network/shared_prepharence_helper.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/widget/move_video.dart';
import 'package:melikaahmadian/app/modules/home/custom_furniture/repository/custome_furniture_repository.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';
import '../controllers/add_details_controller.dart';
import '../repository/add_details_repository.dart';
import '../views/please_search.dart';

class AddDetailsView extends GetView<AddDetailsController> {
  final String? videoPath;
  String? navigatorType ;

   AddDetailsView({super.key, this.videoPath,this.navigatorType});

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;

    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 16.h),

              // Title Section
              Text("Pickup & Drop-off", style: textStyle.titleLarge),



              SizedBox(height: 4.h),
              Text(
                "Where should we move your items?",
                style: textStyle.bodyMedium?.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 16.h),

              // Video Preview
              ClipRRect(
                borderRadius: BorderRadius.circular(12.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: MoveVideo(videoPath: videoPath, isAsset: true),
                ),
              ),
              SizedBox(height: 24.h),

              // Address Details Header
              Text("Address Details", style: textStyle.titleLarge),
              SizedBox(height: 12.h),

              // Pickup Address
              _buildAddressSection(
                context: context,
                title: "Pickup Location",
                icon: Assets.iconsTo,
                address: controller.picupAddress,
                latitude: controller.picupLatitude,
                longitude: controller.picupLongitude,
                onTap: () {
                  Get.to(() => PleaseSearch(selecteddrop: 2));
                },
              ),
              SizedBox(height: 12.h),

              // Pickup Map
              _buildMapSection(
                latitude: controller.picupLatitude,
                longitude: controller.picupLongitude,
                address: controller.picupAddress,
              ),
              SizedBox(height: 16.h),

              // Drop Address
              _buildAddressSection(
                context: context,
                title: "Drop-off Location",
                icon: Assets.iconsFrom,
                address: controller.dropAddress,
                latitude: controller.dropLatitude,
                longitude: controller.dropLongitude,
                onTap: () {
                  Get.to(() => PleaseSearch(selecteddrop: 1));
                },
              ),
              SizedBox(height: 12.h),

              // Drop Map
              _buildMapSection(
                latitude: controller.dropLatitude,
                longitude: controller.dropLongitude,
                address: controller.dropAddress,
              ),
              SizedBox(height: 24.h),

              // Time Details Section
              Text("Date Details", style: textStyle.titleLarge),
              SizedBox(height: 12.h),

              // Date Picker
              TextField(
                controller: controller.dataEditingController,
                readOnly: true,
                onTap: () => controller.selectDate(context),
                decoration: InputDecoration(
                  hintText: "Select date",
                  prefixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.secoundaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                    borderSide: BorderSide(color: AppColors.secoundaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                    borderSide: BorderSide(color: AppColors.secoundaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                    borderSide: BorderSide(
                      color: AppColors.secoundaryColor,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
              SizedBox(height: 12.h),
              Text("Time Details", style: textStyle.titleLarge),
              SizedBox(height: 12.h),
              // Time Picker
              TextField(
                controller: controller.timeEditingController,
                readOnly: true,
                onTap: () => controller.selectTime(context),
                decoration: InputDecoration(
                  hintText: "Select time",
                  prefixIcon: Icon(
                    Icons.access_time_outlined,
                    color: AppColors.secoundaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                    borderSide: BorderSide(color: AppColors.secoundaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                    borderSide: BorderSide(color: AppColors.secoundaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.w),
                    borderSide: BorderSide(
                      color: AppColors.secoundaryColor,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
              SizedBox(height: 24.h),

              // House Type Selection
              Text("House Type Selection", style: textStyle.titleLarge),
              SizedBox(height: 12.h),

              Obx(
                () => GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1.2,
                  children: List.generate(controller.houseType.length, (index) {
                    var data = controller.houseType[index];
                    bool isSelected =
                        controller.selectedHouseType.value == index;

                    return InkWell(
                      onTap: () {
                        controller.selectedHouseType.value = index;
                        controller.selectedDateText.value = data.titel ?? "";
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.secoundaryColor
                              : AppColors.onPrimaryColor,
                          borderRadius: BorderRadius.circular(12.w),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.secoundaryColor
                                : AppColors.secoundaryColor.withOpacity(0.3),
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.secoundaryColor
                                        .withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              data.iconPath ?? "",
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.secoundaryColor,
                              height: 48.h,
                              width: 48.w,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              data.titel ?? "",
                              style: textStyle.bodyMedium?.copyWith(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.secoundaryColor,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 12.h),
              navigatorType == "ai" ?  Text("House Type Selection", style: textStyle.titleLarge) : SizedBox(),
              SizedBox(height: 12.h),
              navigatorType == "ai" ?  TextFormField(
                controller: controller.roomTextEditingController,
                cursorHeight: 16.h,
                style: textStyle.labelLarge!.copyWith(
                  color: AppColors.secoundaryColor,
                ),
                decoration: InputDecoration(hintText: "Total rooms in the home (bedrooms, kitchen, store, etc.)"),
              )  : SizedBox() ,
              SizedBox(height: 24.h),

              // Submit Button
             Obx(() =>   AppButton(
               titel: navigatorType == "ai"
                   ? "Get AI Quote"
                   : 'Select Your Items',
              onPress: () => _handleSubmit(context,navigatorType: navigatorType,videourl: videoPath),
              //  onPress: (){
              //    debugPrint("mover");
              //    final file = File(videoPath!);
              //
              //  },
               isLoding: controller.isLoading.value,
               child: false,
             ),),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit(BuildContext context , {String? navigatorType,String? videourl}) async {
    if (!controller.validateAllFields()) {
      Get.snackbar(
        "Required Fields",
        "Please fill in all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    debugPrint("navigator type ${navigatorType}");

    if (navigatorType == "ai") {
      controller.isLoading.value = true;
      try {
        final file = File(videourl!);
        Get.toNamed(Routes.ALL_ITEM,arguments: {
         AppArgumentString.navigatorType : "ai"
        });
     //  controller.analayzeVideo(videoFile: file);
        //await AddDetailsRepository.aiGenaredVideo();

        controller.distance.value =
            Geolocator.distanceBetween(
              double.parse(controller.picupLatitude.value),
              double.parse(controller.picupLongitude.value),
              double.parse(controller.dropLatitude.value),
              double.parse(controller.dropLongitude.value),
            ) /
            1000;

        // Navigate after success
        // Get.toNamed(Routes.AI_QUOTE);
      } catch (e) {
        Get.snackbar("Error", "Failed to generate quote");
      } finally {
        controller.isLoading.value = false;
      }
    } else {
      try {
        await CustomeFurnitureRepository.getFurnitureByCatagory("");
        Get.toNamed(Routes.CUSTOM_FURNITURE);
      } catch (e) {
        Get.snackbar("Error", "Failed to load furniture");
      }
    }
  }

  Widget _buildAddressSection({
    required BuildContext context,
    required String title,
    required String icon,
    required RxString address,
    required RxString latitude,
    required RxString longitude,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelLarge),
        SizedBox(height: 8.h),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.w),
              border: Border.all(color: AppColors.secoundaryColor),
              color: AppColors.primaryColor,
            ),
            child: Row(
              children: [
                Image.asset(icon, height: 24.h, width: 24.w),
                SizedBox(width: 12.w),
                Expanded(
                  child: Obx(
                    () => AutoSizeText(
                      address.value.isEmpty
                          ? "Enter ${title.toLowerCase()}"
                          : address.value,
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16.w),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapSection({
    required RxString latitude,
    required RxString longitude,
    required RxString address,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.w),
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Obx(() {
          final double lat = double.tryParse(latitude.value) ?? 23.8103;
          final double lng = double.tryParse(longitude.value) ?? 90.4125;
          final String addr = address.value;

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, lng),
              zoom: 15,
            ),
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            markers: addr.isNotEmpty
                ? {
                    Marker(
                      markerId: MarkerId("location"),
                      position: LatLng(lat, lng),
                      infoWindow: InfoWindow(title: addr),
                    ),
                  }
                : {},
          );
        }),
      ),
    );
  }
}
