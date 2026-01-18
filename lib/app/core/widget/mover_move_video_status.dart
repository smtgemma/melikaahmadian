import 'package:auto_size_text/auto_size_text.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/network/shared_prepharence_helper.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/status.dart';
import 'package:melikaahmadian/app/modules/move/offer_review/widget/offer.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'package:video_player/video_player.dart';
import '../../modules/move/controllers/move_controller.dart';
import '../../modules/move/offer_review/controllers/offer_review_controller.dart';
import '../../modules/mover/mover_move/mover_move_detils/controllers/mover_move_detils_controller.dart';
import 'move_post_video.dart';

class MoverMoveStatusVideo extends StatelessWidget {
  String? offer;
  bool? isOffer;
  String? price;
  String? date;
  String? to;
  String? from;
  bool? isNavigator;
  String? titel;
  Color? color;
  Color? textColor;
  String? isType;
  String? videoUrl;
  String? postId;

  MoverMoveStatusVideo({
    super.key,
    this.price,
    this.date,
    this.offer,
    this.to,
    this.from,
    this.isNavigator,
    this.titel,
    this.color,
    this.textColor,
    this.isType,
    this.isOffer,
    this.videoUrl,
    this.postId,
  });

  @override
  Widget build(BuildContext context) {
    var textStyele = Theme.of(context).textTheme;
    final moverController = Get.put(MoverMoveDetilsController());

   //  final controller = Get.put(MoveController());
    final offercontroller = Get.put(OfferReviewController());

    return Container(
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: double.infinity,
            width: 144,
            child: Stack(
              children: [
                SizedBox(
                  height: 150,
                  child: SafeMoveVideo(),
                ),

                /// Offer Badge
                (isOffer == true)
                    ?  SizedBox()
                    : Positioned(
                  child: AppButton(
                    containerColor: 1,
                    width: 71.w,
                    titel: "${offer ?? "2"} offer",
                    hight: 21.h,
                    textSize: 14,
                    bodycolor: AppColors.primaryColor,
                  ),
                ),

                /// Price & Date
                Positioned(
                  bottom: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(Assets.iconsDolar),
                          const SizedBox(width: 4),
                          Text(
                            price ?? "320",
                            style: textStyele.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        date ?? "26 Nov 2025",
                        style: textStyele.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 10.w),


          /// Right Side Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// To
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(Assets.iconsTo),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AutoSizeText(
                        to ?? "12/24, Toronto",
                        maxLines: 1,
                        style: textStyele.bodyMedium!.copyWith(
                          color: AppColors.secoundaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                /// From
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(Assets.iconsFrom),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AutoSizeText(
                        from ?? "12/24, Toronto",
                        maxLines: 1,
                        style: textStyele.bodyMedium!.copyWith(
                          color: AppColors.secoundaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                /// Status Button
                InkWell(
                  onTap: () {
                    if (isNavigator == true && offer != "" ) {

                       if (isType == AppArgumentString.Offered) {
                        Get.toNamed(Routes.MOVER_MOVE_DETILS_SEND_OFFER);
                      } else if (isType == AppArgumentString.moverPending) {
                         Get.toNamed(Routes.MOVER_MOVE_COMPLEDET_DETILS,arguments: {
                           AppArgumentString.moverStatus: "Pending",
                           AppArgumentString.postId: postId,
                         });
                         moverController.getDetails(pram: postId);
                      } else if (isType == AppArgumentString.moverAccepted) {
                         SharedPrefHelper.setString(SharedPrefHelper.postId, postId.toString());
                        Get.toNamed(Routes.MOVER_MOVE_DETILS,arguments: {
                          AppArgumentString.moverStatus: "Accepted",
                          AppArgumentString.postId: postId,
                        });
                        offercontroller.selectedOfferDetails.value = "Update Status";
                        moverController.getDetails(pram: postId);
                        moverController.getStatus(pram: postId);
                      } else if (isType == AppArgumentString.moverRejected) {
                         Get.toNamed(Routes.MOVER_MOVE_COMPLEDET_DETILS,arguments: {
                           AppArgumentString.moverStatus: "Rejected",
                           AppArgumentString.postId: postId,
                         });
                         moverController.getDetails(pram: postId);
                      } else if (isType == AppArgumentString.movercenceled) {
                         Get.toNamed(Routes.MOVER_MOVE_COMPLEDET_DETILS,arguments: {
                           AppArgumentString.moverStatus: "Cancelled",
                           AppArgumentString.postId: postId,
                         });
                         moverController.getDetails(pram: postId);
                       }else if (isType == AppArgumentString.movercompeleted) {
                         Get.toNamed(Routes.MOVER_MOVE_COMPLEDET_DETILS,arguments: {
                           AppArgumentString.moverStatus: "Completed",
                           AppArgumentString.postId: postId,
                         });
                         moverController.getDetails(pram: postId);
                       }else if (isType == AppArgumentString.moverPosted) {
                         Get.toNamed(Routes.MOVER_MOVE_DETILS_SEND_OFFER,arguments: {

                           AppArgumentString.postId: postId,
                         });
                         moverController.getDetails(pram: postId);
                       }
                    } else if (isNavigator == true && offer == "0"){
                      Get.snackbar("No offer available", "");
                      debugPrint("Navigator disabled");
                    }
                  },
                  child: Status(
                    titel: titel,
                    color: color,
                    textColor: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


