import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../core/const/app_argument_string.dart';
import '../../../../../core/const/app_colors.dart';
import '../../../../../core/widget/App_button.dart';
import '../../../../../core/widget/furniture_type.dart';
import '../../../../../core/widget/move_video.dart';
import '../../../../home/custom_furniture/widget/produc_countity.dart';
import '../../../../move/offer_review/model/details_model.dart';
import '../../../../move/offer_review/widget/single_information.dart';
import '../controllers/mover_move_detils_send_offer_controller.dart';
import '../repository/mover_move_detils_reposioty.dart';
class MoverDetils extends StatelessWidget {
  bool? isCencel;
  bool? isRequestButton;

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
  String? offerId;

  String ? picAddress;

  String? dropAddress;

  String? videoPath;

  String? ratring;
  String? price;
   MoverDetils({super.key,this.name, this.starRation, this.reviewRating, this.isCencel, this.picLat, this.picLong, this.drolat, this.drolong, this.data, this.time, this.selectedType, this.listfurniture, this.postId, this.picAddress, this.dropAddress, this.videoPath, this.ratring,this.isRequestButton,this.price,this.offerId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MoverMoveDetilsSendOfferController());
    var textStyele = TextTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MoveVideo(videoPath: videoPath,),
        SizedBox(height: 24.h),
        Text("Your mover", style: textStyele.titleLarge),
        SizedBox(height: 12.h),
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
        ProducCountity(isReview: true),
        Text("Send Your Offer Price", style: textStyele.titleLarge),
        SizedBox(height: 04.h),
        Text("Send an custom offer to the client.", style: textStyele.bodyMedium),
        SizedBox(height: 12.h),
        Container(
          height: 52.h,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.cardColor,borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Container(
                  height: double.infinity,
                  width: 54.w,
                  decoration: BoxDecoration(color: AppColors.secoundaryColor,borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r),bottomLeft: Radius.circular(12.r))),
                  child: Center(child: Text("\$",style: textStyele.headlineLarge!.copyWith(color: AppColors.primaryColor),),)),
              Expanded(
                child: TextField(
                  controller: controller.priceEditinController,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.secoundaryColor,
                  cursorHeight: 20.h,
                  decoration: const InputDecoration(
                    hintText: "Write your offer price",
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              )

            ],
          ),
        ),
        SizedBox(height: 24.h),
        Obx(() =>  AppButton(
          titel: "Send This Offer",
          onPress: () {
            MoverMoveDetilsReposioty.sendOffer(postId: controller.postId) ;


          },
          isLoding: controller.isLoading.value,
        ),),

        SizedBox(height: 24.h),
      ],
    );
  }
}
