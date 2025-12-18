import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
class MoveStatusVideo extends StatelessWidget {
  String? offer ;
  String? price ;
  String? date ;
  String? to ;
  String? from ;
  bool? isNavigator ;
  String? titel ;
  Color? color ;
  Color? textColor ;
  String? isType ;

   MoveStatusVideo({super.key,this.price,this.date,this.offer,this.to,this.from,this.isNavigator,this.titel,this.color,this.textColor,this.isType});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

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
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: double.infinity,
              width: 144,
              child: Stack(children: [
                SizedBox(
                  height: 150,
      
                  child: FutureBuilder(
                    future: controller.initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          controller.chewieController != null) {
                        return Chewie(controller: controller.chewieController!);
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return SizedBox(
                            height: 40,
                            width: 40,
                            child:  Center(child: CircularProgressIndicator()));
                      }
                    },
                  ),
                ),
                Positioned(child: AppButton(containerColor: 1,width: 71.w,titel: "${offer ?? "2"} offer",hight: 21.h,textSize: 14,bodycolor: AppColors.primaryColor,)),
                Positioned(
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Image.asset(Assets.iconsDolar),
                      SizedBox(width: 04,),
                      Text( price??"320" ,style: textStyele.bodyMedium!.copyWith(fontWeight: FontWeight.bold,color: AppColors.primaryColor),)
                    ],),
                    SizedBox(height: 02.h,),
                    Text( date??"26 Nov 2025" ,style: textStyele.bodyMedium!.copyWith(fontWeight: FontWeight.bold,color: AppColors.primaryColor),)
      
                  ],
                ))
      
              ],),
            ),
            SizedBox(width: 10.w ,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //to
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(Assets.iconsTo),
                      SizedBox(width: 08,),
                      Expanded(child: Text("12/24, Toronto",maxLines:1,style: textStyele.bodyMedium!.copyWith(color: AppColors.secoundaryColor),))
      
                    ],
                  ),
                  //from
                  SizedBox(height: 08,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(Assets.iconsFrom),
                      SizedBox(width: 08,),
                      Expanded(child: Text("12/24, Toronto",maxLines: 1,style: textStyele.bodyMedium!.copyWith(color: AppColors.secoundaryColor),)),
      
      
                    ],
                  ),
                  SizedBox(height: 08,),
                  InkWell(
                    onTap: (){
                      if(isNavigator == true ){
                        if(isType == AppArgumentString.posted){
                          Get.toNamed(Routes.OFFER_REVIEW,arguments: {
                            AppArgumentString.offer : offer ?? 5
                          });
                          offercontroller.selectedOfferDetails.value = "offer" ;

                        }
                        if(isType == AppArgumentString.ongoing){
                          Get.toNamed(Routes.ONGOING_MOVER_DETAILS);
                          offercontroller.selectedOfferDetails.value = "Details" ;
                        }
                        } if(isType == AppArgumentString.cancelled){
                        debugPrint("cencel");
                          Get.toNamed(Routes.CENCEL_MOVE);
                        }


                      },

                  child: Status(titel: titel,color: color,textColor: textColor,))
      
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
