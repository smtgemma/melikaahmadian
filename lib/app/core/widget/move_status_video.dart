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
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'package:video_player/video_player.dart';
import '../../modules/move/controllers/move_controller.dart';
import '../../modules/move/offer_review/controllers/offer_review_controller.dart';
class MoveStatusVideo extends StatefulWidget {
  String? offer ;
  bool? isOffer ;
  String? price ;
  String? date ;
  String? to ;
  String? from ;
  bool? isNavigator ;
  String? titel ;
  Color? color ;
  Color? textColor ;
  String? isType ;
  String? videoUrl ;

   MoveStatusVideo({super.key,this.price,this.date,this.offer,this.to,this.from,this.isNavigator,this.titel,this.color,this.textColor,this.isType,this.isOffer,this.videoUrl});

  @override
  State<MoveStatusVideo> createState() => _MoveStatusVideoState();
}

class _MoveStatusVideoState extends State<MoveStatusVideo> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.videoUrl ??
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    );

    initializeVideoPlayerFuture =
        videoPlayerController.initialize().then((_) {
          chewieController = ChewieController(
            videoPlayerController: videoPlayerController,
            autoPlay: false,
            fullScreenByDefault: true,
            looping: false,
            allowFullScreen: false,
            showControls: false,
            aspectRatio: videoPlayerController.value.aspectRatio,
            allowPlaybackSpeedChanging: true,
            deviceOrientationsAfterFullScreen: const [
              DeviceOrientation.portraitUp,
            ],
            deviceOrientationsOnEnterFullScreen: const [
              DeviceOrientation.landscapeRight,
              DeviceOrientation.landscapeLeft,
            ],
          );

          videoPlayerController.pause();
          setState(() {});
        });
  }

  @override
  void dispose() {
    chewieController?.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textStyele = Theme.of(context).textTheme;

    final controller = Get.put(MoveController());
    final offercontroller = Get.put(OfferReviewController());

    return InkWell(
      child: Container(
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
                    child: FutureBuilder(
                      future: initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.done &&
                            chewieController != null) {
                          return Chewie(controller: chewieController!);
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          return const Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  /// Offer Badge
                  widget.isOffer == true
                      ? const SizedBox()
                      : Positioned(
                    child: AppButton(
                      containerColor: 1,
                      width: 71.w,
                      titel: "${widget.offer ?? "2"} offer",
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
                              widget.price ?? "320",
                              style: textStyele.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          widget.date ?? "26 Nov 2025",
                          style: textStyele.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  )
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
                           widget.to ?? "12/24, Toronto",
                          maxLines: 1,
                          style: textStyele.bodyMedium!.copyWith(
                            color: AppColors.secoundaryColor,
                          ),
                        ),
                      )
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
                          widget.from ?? "12/24, Toronto",
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
                      if (widget.isNavigator == true) {
                        if (widget.isType ==
                            AppArgumentString.posted) {
                          Get.toNamed(
                            Routes.OFFER_REVIEW,
                            arguments: {
                              AppArgumentString.offer:
                              widget.offer ?? 5,
                            },
                          );
                          offercontroller.selectedOfferDetails
                              .value = "offer";
                        } else if (widget.isType ==
                            AppArgumentString.ongoing) {
                          Get.toNamed(
                              Routes.ONGOING_MOVER_DETAILS);
                          offercontroller.selectedOfferDetails
                              .value = "Details";
                        } else if (widget.isType ==
                            AppArgumentString.cancelled) {
                          Get.toNamed(Routes.CENCEL_MOVE);
                        } else if (widget.isType ==
                            AppArgumentString.Offered) {
                          Get.toNamed(
                              Routes.MOVER_MOVE_DETILS_SEND_OFFER);
                        } else if (widget.isType ==
                            AppArgumentString.moverOngoing) {
                          Get.toNamed(Routes.MOVER_MOVE_DETILS);
                        } else if (widget.isType ==
                            AppArgumentString.movercompeleted) {
                          Get.toNamed(
                              Routes.MOVER_MOVE_COMPLEDET_DETILS);
                        } else if (widget.isType ==
                            AppArgumentString.movercenceled) {
                          Get.toNamed(
                              Routes
                                  .MOVER_INFORMATION_ABOUT_THE_CANCALATION);
                        } else {
                          debugPrint(
                              "Unknown type: ${widget.isType}");
                        }
                      } else {
                        debugPrint("Navigator disabled");
                      }
                    },
                    child: Status(
                      titel: widget.titel,
                      color: widget.color,
                      textColor: widget.textColor,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

