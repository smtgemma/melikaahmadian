import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:melikaahmadian/app/modules/home/ai_genared_price/model/mopst_request_model.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../core/widget/app_image_frame_radious_widget.dart';
import '../../../../core/widget/furniture_type.dart';
import '../../../../core/widget/move_video.dart';
import '../../../home/custom_furniture/widget/produc_countity.dart';
import '../../offer_review/controllers/offer_review_controller.dart';
import '../../offer_review/model/details_model.dart';
import '../../offer_review/repository/offer_review_repository.dart';
import '../../offer_review/widget/single_information.dart';
import 'package:get/get.dart';
class OngingDetails extends StatelessWidget {
  bool? isCencel;

  String? name;

  String? starRation;

  String? reviewRating;

  double? picLat;

  double? picLong;

  double? drolat;

  double? drolong;

  String? data;

  String? time;

  String? selectedType;

  List<FurnitureModel>? listfurniture;

  String? postId;

  String ? picAddress;

  String? dropAddress;

  String? videoPath;

  String? ratring;


  OngingDetails(
      {super.key, this.name, this.starRation, this.reviewRating, this.isCencel, this.picLat, this.picLong, this.drolat, this.drolong, this.data, this.time, this.selectedType, this.listfurniture, this.postId, this.picAddress, this.dropAddress, this.videoPath, this.ratring});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MoveVideo(),
        SizedBox(height: 24.h,),
        Text("Your mover", style: textStyele.titleLarge),
        SizedBox(height: 12.h),
        Stack(children: [
          Container(
            //  height: 150.h,
            padding: EdgeInsets.all(16.w),
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.secoundaryColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppImageFrameRadiousWidget(radious: 25,),
                    SizedBox(width: 20.w,),
                    Column(
                      children: [
                        Text(name ?? "Mike James",
                          style: textStyele.titleMedium!.copyWith(
                              color: AppColors.primaryColor),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset(Assets.iconsColorStar),
                                SizedBox(width: 04,),
                                Text(ratring ?? "4.5",
                                  style: textStyele.bodyMedium!.copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 14),)
                              ],
                            ),
                            SizedBox(width: 08.w,),
                            Text("${reviewRating ?? "152"} Reviews",
                                style: textStyele.bodyMedium!.copyWith(
                                    color: AppColors.primaryColor)),
                          ],),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h,),
                Row(
                  children: [
                    Expanded(child: AppButton(containerColor: 1,
                      child: true,
                      titel: "Call",
                      iconPath: Assets.iconsCall,)),
                    SizedBox(width: 12.w,),
                    Expanded(child: AppButton(
                      borderColor: AppColors.textSecoundaryColor,
                      child: true,
                      titel: "Chat",
                      iconPath: Assets.iconsChat,))
                  ],
                )


              ],
            ),
          ),
          Positioned(
            top: -40,
            left: -40,
            child: Container(
              height: 123.h,
              width: 123.w,
              decoration: BoxDecoration(
                  color: AppColors.shadoColor.withAlpha(10),
                  shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -60,
            child: Container(
              height: 123.h,
              width: 123.w,
              decoration: BoxDecoration(
                  color: AppColors.shadoColor.withAlpha(10),
                  shape: BoxShape.circle),
            ),
          )
        ],),
        SizedBox(height: 24.h),
        SingleInformation(
            isChild: true, titel: picAddress ?? "Toronto, Canada"),
        SizedBox(height: 12.h),
        Container(
          height: 145.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w),
            color: Colors.grey,
          ),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(picLat ?? 23.8103, picLong ?? 90.4125),
              zoom: 15,
            ),
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            markers: {
              Marker(
                markerId: const MarkerId("location"),
                position: LatLng(picLat ?? 23.8103, picLong ?? 90.4125),
                infoWindow: InfoWindow(title: picAddress ?? ""),
              ),
            },
          ),
        ),
        SizedBox(height: 12.h),
        SingleInformation(
          isChild: true,
          titel: dropAddress ?? "Toronto, Canada",
          iconPath: Assets.iconsFrom,
        ),
        SizedBox(height: 12.h),
        Container(
          height: 145.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w),
            color: Colors.grey,
          ),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(drolat ?? 23.8103, drolong ?? 90.4125),
              zoom: 15,
            ),
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            markers: {
              Marker(
                markerId: const MarkerId("location"),
                position: LatLng(drolat ?? 23.8103, drolong ?? 90.4125),
                infoWindow: InfoWindow(title: dropAddress ?? ""),
              ),
            },
          ),
        ),
        SizedBox(height: 24.h),
        Text("Time Details", style: textStyele.titleLarge),
        SizedBox(height: 12.h),
        SingleInformation(
          isChild: true,
          titel: data ?? "",
          iconPath: Assets.iconsCalender,
        ),
        SizedBox(height: 12.h),
        SingleInformation(
          isChild: true,
          titel: time ?? "",
          iconPath: Assets.iconsQuite,
        ),
        SizedBox(height: 24.h),
        Text("Selected House Type", style: textStyele.titleLarge),
        SizedBox(height: 12.h),
        SingleInformation(titel: selectedType ?? ""),
        SizedBox(height: 24.h),
        Text("Selected Furnitures", style: textStyele.titleLarge),
        SizedBox(height: 12.h),
        ...List.generate(listfurniture?.length ?? 0,
              (index) {
            final item = listfurniture?[index];

            return FurnitureType(
              titel: item?.name ?? "furniture",
              quantity: item?.quantity.toString() ?? "1",
            );
          },
        ),
        isCencel == true ? SizedBox(height: 24.h) : AppButton(
          titel: "Request To Cancel Move",
          onPress: () {
            bottomSheet(context,id: postId);
          },
        ),

        SizedBox(height: 24.h),
      ],
    );
  }
  void bottomSheet(BuildContext context, {String? id}) {
    final controller = Get.put(OfferReviewController());
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