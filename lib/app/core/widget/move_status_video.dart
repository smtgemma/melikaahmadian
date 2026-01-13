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

class MoveStatusVideo extends StatelessWidget {
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
  Widget build(BuildContext context) {
    var textStyele = Theme.of(context).textTheme;

    final controller = Get.put(MoveController());
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
                  child: SafeMoveVideo(videoUrl: videoUrl,),
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
                    if (isNavigator == true && offer != "0" ) {
                      if (isType == AppArgumentString.posted) {
                      //  Get.put(OfferReviewController());

                        Get.toNamed(
                          Routes.OFFER_REVIEW,
                          arguments: {
                            AppArgumentString.offer: offer ?? 5,
                            AppArgumentString.postId: postId,
                          },
                        );
                        offercontroller.selectedOfferDetails.value = "offer";
                      } else if (isType == AppArgumentString.ongoing) {
                        Get.toNamed(Routes.ONGOING_MOVER_DETAILS);
                        offercontroller.selectedOfferDetails.value = "Details";
                      } else if (isType == AppArgumentString.cancelled) {
                        Get.toNamed(Routes.CENCEL_MOVE);
                      } else if (isType == AppArgumentString.Offered) {
                        Get.toNamed(Routes.MOVER_MOVE_DETILS_SEND_OFFER);
                      } else if (isType ==
                          AppArgumentString.moverOngoing) {
                        Get.toNamed(Routes.MOVER_MOVE_DETILS);
                      } else if (isType ==
                          AppArgumentString.movercompeleted) {
                        Get.toNamed(Routes.MOVER_MOVE_COMPLEDET_DETILS);
                      } else if (isType ==
                          AppArgumentString.movercenceled) {
                        Get.toNamed(
                          Routes.MOVER_INFORMATION_ABOUT_THE_CANCALATION,
                        );
                      } else {
                        debugPrint("Unknown type: $isType");
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


class SafeMoveVideo extends StatefulWidget {
  final String? videoUrl;
  const SafeMoveVideo({super.key, this.videoUrl});

  @override
  State<SafeMoveVideo> createState() => _SafeMoveVideoState();
}

class _SafeMoveVideoState extends State<SafeMoveVideo> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isError = false;
  bool _isInitialized = false;
  bool _userWantsToPlay = false; // Add this flag

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    );

    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false, //video inital vabe off takbe
        fullScreenByDefault: true,
        looping: false,
        allowFullScreen: false,
        showControls: false, //video inital vabe off takbe
        aspectRatio: _videoPlayerController.value.aspectRatio,
        allowPlaybackSpeedChanging: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp, // fullscreen থেকে বের হলে আবার portrait
        ],
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft, // fullscreen গেলে landscape হবে
        ],
      );
      _videoPlayerController.pause();
      setState(() {});
    });
  }

  // Future<void> _initializeVideo() async {
  //   if (widget.videoUrl == null || widget.videoUrl!.isEmpty) {
  //     setState(() => _isError = true);
  //     return;
  //   }
  //
  //   try {
  //     _controller = VideoPlayerController.network(widget.videoUrl!);
  //     await _controller!.initialize();
  //
  //     if (!mounted) return;
  //
  //     _chewieController = ChewieController(
  //       videoPlayerController: _controller!,
  //       autoPlay: true, // Auto-play once initialized
  //       looping: false,
  //       showControls: true,
  //       allowFullScreen: false,
  //     );
  //
  //     setState(() => _isInitialized = true);
  //   } catch (e) {
  //     debugPrint("⚠️ Video init error: $e");
  //     if (mounted) setState(() => _isError = true);
  //   }
  // }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return Container(
        height: 120,
        color: Colors.black12,
        alignment: Alignment.center,
        child: const Text("Video not available"),
      );
    }

    if (!_userWantsToPlay) {
      // Show a thumbnail/preview with play button
      return GestureDetector(
        onTap: () {
          setState(() => _userWantsToPlay = true);
        //  _initializeVideo();
        },
        child: Container(
          height: 120,
          color: Colors.black12,
          alignment: Alignment.center,
          child: const Icon(
            Icons.play_circle_outline,
            size: 48,
            color: Colors.white,
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: 120,
      child: Chewie(controller: _chewieController!),
    );
  }
}