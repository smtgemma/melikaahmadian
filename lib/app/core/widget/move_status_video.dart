import 'package:auto_size_text/auto_size_text.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/status.dart';
import 'package:melikaahmadian/app/modules/move/offer_review/widget/offer.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'package:video_player/video_player.dart';
import '../../modules/move/controllers/move_controller.dart';
import '../../modules/move/offer_review/controllers/offer_review_controller.dart';
import 'move_post_video.dart';
import 'moves_post_video.dart';

class MoveStatusVideo extends StatefulWidget {
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

  MoveStatusVideo({
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
  State<MoveStatusVideo> createState() => _MoveStatusVideoState();
}

class _MoveStatusVideoState extends State<MoveStatusVideo> {
  late VideoPlayerController? _videoController;
  bool _isVideoReady = false;
  bool _videoError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    if (widget.videoUrl != null && widget.videoUrl!.isNotEmpty) {
      try {
        _videoController = VideoPlayerController.networkUrl(
          Uri.parse(widget.videoUrl!),
        )..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isVideoReady = true;
              _videoError = false;
            });
          }
        }).catchError((e) {
          debugPrint("Video initialization error: $e");
          if (mounted) {
            setState(() {
              _videoError = true;
              _isVideoReady = false;
            });
          }
        });
      } catch (e) {
        debugPrint("Video URL error: $e");
        if (mounted) {
          setState(() {
            _videoError = true;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Widget _buildVideoWidget() {
    if (_videoError || widget.videoUrl == null || widget.videoUrl!.isEmpty) {
      return Container(
        color: AppColors.cardColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image_not_supported_outlined,
                  color: AppColors.secoundaryColor, size: 40),
              SizedBox(height: 8.h),
              Text(
                'No Video',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
    }

    if (!_isVideoReady) {
      return Container(
        color: AppColors.cardColor,
        child: Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              color: AppColors.secoundaryColor,
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        VideoPlayer(_videoController!),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.play_arrow,
                color: Colors.white, size: 32),
          ),
        ),
      ],
    );
  }

  void _handleStatusTap() {
    if (widget.isNavigator == true && widget.offer != "") {
      if (widget.isType == AppArgumentString.posted) {
        debugPrint("postid: ${widget.postId}");
        final offercontroller = Get.find<OfferReviewController>();
        offercontroller.getDetails(pram: widget.postId);
        offercontroller.getOffer(pram: widget.postId);

        Get.toNamed(
          Routes.OFFER_REVIEW,
          arguments: {
            AppArgumentString.offer: widget.offer ?? 5,
            AppArgumentString.postId: widget.postId,
          },
        );
        offercontroller.selectedOfferDetails.value = "offer";
        offercontroller.offerDetailsControole(isoffer: 1);
      } else if (widget.isType == AppArgumentString.ongoing) {
        Get.toNamed(Routes.ONGOING_MOVER_DETAILS, arguments: {
          AppArgumentString.postId: widget.postId,
        });
        final offercontroller = Get.find<OfferReviewController>();
        offercontroller.offerDetailsControole(isoffer: 1);
        offercontroller.selectedOfferDetails.value = "Details";
      } else if (widget.isType == AppArgumentString.cancelled) {
        debugPrint("postid: ${widget.postId}");
        Get.toNamed(Routes.CENCEL_MOVER_DETAILS, arguments: {
          AppArgumentString.postId: widget.postId,
        });
      } else if (widget.isType == AppArgumentString.completed) {
        debugPrint("postid: ${widget.postId}");
        Get.toNamed(Routes.CENCEL_MOVER_DETAILS, arguments: {
          AppArgumentString.postId: widget.postId,
          AppArgumentString.moverStatus: "Completed",
        });
      } else if (widget.isType == AppArgumentString.Offered) {
        Get.toNamed(Routes.MOVER_MOVE_DETILS_SEND_OFFER);
      } else if (widget.isType == AppArgumentString.moverOngoing) {
        Get.toNamed(Routes.MOVER_MOVE_DETILS);
      } else if (widget.isType == AppArgumentString.movercompeleted) {
        Get.toNamed(Routes.MOVER_MOVE_COMPLEDET_DETILS);
      } else if (widget.isType == AppArgumentString.movercenceled) {
        Get.toNamed(
          Routes.MOVER_INFORMATION_ABOUT_THE_CANCALATION,
        );
      } else {
        debugPrint("Unknown type: ${widget.isType}");
      }
    } else if (widget.isNavigator == true && widget.offer == "0") {
      Get.snackbar(
        "No offer available",
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.secoundaryColor,
        colorText: Colors.white,
      );
      debugPrint("Navigator disabled");
    }
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;

    return Container(
      height: 120.h,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Video Section
          SizedBox(
            height: double.infinity,
            width: 144.w,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _buildVideoWidget(),
                ),

                /// Offer Badge
                if (widget.isOffer != true)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: AppButton(
                      containerColor: 1,
                      width: 71.w,
                      titel: "${widget.offer ?? "2"} offer",
                      hight: 21.h,
                      textSize: 12.sp,
                      bodycolor: AppColors.primaryColor,
                    ),
                  ),

                /// Price & Date
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(Assets.iconsDolar, scale: 2),
                            const SizedBox(width: 4),
                            Text(
                              widget.price ?? "320",
                              style: textStyle.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          widget.date ?? "26 Nov 2025",
                          style: textStyle.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          /// Right Side Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// To Address
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Image.asset(Assets.iconsTo, scale: 2),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AutoSizeText(
                          widget.to ?? "12/24, Toronto",
                          maxLines: 2,
                          minFontSize: 10,
                          style: textStyle.bodyMedium!.copyWith(
                            color: AppColors.secoundaryColor,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// From Address
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Image.asset(Assets.iconsFrom, scale: 2),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AutoSizeText(
                          widget.from ?? "12/24, Toronto",
                          maxLines: 2,
                          minFontSize: 10,
                          style: textStyle.bodyMedium!.copyWith(
                            color: AppColors.secoundaryColor,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Status Button
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _handleStatusTap,
                      borderRadius: BorderRadius.circular(8),
                      child: Status(
                        titel: widget.titel,
                        color: widget.color,
                        textColor: widget.textColor,
                      ),
                    ),
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