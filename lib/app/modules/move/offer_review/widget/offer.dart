import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_image_frame_radious_widget.dart';
import 'package:melikaahmadian/app/core/widget/move_video.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../../../core/network/shared_prepharence_helper.dart';
import '../../mover_profiel_details/controllers/mover_profiel_details_controller.dart';
import '../../mover_profiel_details/views/mover_profiel_details_view.dart';
import '../../mover_profiel_details/widget/experence_box.dart';
import '../controllers/offer_review_controller.dart';

class Offer extends StatelessWidget {
  String? imageLink;
  String? videoLink;
  String? name;
  String? starRation;
  String? reviewRating;

  Offer({
    super.key,
    this.imageLink,
    this.videoLink,
    this.name,
    this.starRation,
    this.reviewRating,

  });

  @override
  Widget build(BuildContext context) {
    print("=====================Showing Offer view");


      final controller = Get.find<OfferReviewController>();
      var textStyele = TextTheme.of(context);
      //return Text("data") ;

      return Expanded(
        child:  Obx(() {
           var data = controller.offerModel.value.data ;
          if(controller.offerLoading.value){
            return Center(child: CircularProgressIndicator(color: AppColors.secoundaryColor,),);
          }else if (data == null || data.isEmpty) {
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

           // return ListView.builder(
          //   itemCount: 10,
          //   itemBuilder: (context, index) {
          //   return Text("data");
          // },) ;
          return  ListView.builder(
            itemCount: controller.offerModel.value.data?.length ?? 0,
            itemBuilder: (context, index) {
              final   data = controller.offerModel.value.data?[index];
             // return Text("data");
              return  Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: MoveVideo(videoPath: data?.postMedia?[0].url ?? "",isasset: true,),
                  ),
                  Text( data?.postMedia?[0].url ?? ""),

                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        ListTile(
                          leading: AppImageFrameRadiousWidget(radious: 30),
                          title: Text(
                              data?.provider?.fullName ?? "Mike James",
                              style: textStyele.titleMedium
                          ),
                          subtitle: Row(
                            children: [
                              Row(
                                children: [
                                  // Safe icon loading
                                  Icon(
                                    Icons.star,
                                    color: AppColors.secoundaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: 04),
                                  Text(
                                      data?.provider?.averageRating.toString() ?? "0",
                                      style: textStyele.bodyMedium!.copyWith(
                                          color: AppColors.secoundaryColor,
                                          fontSize: 14
                                      )
                                  )
                                ],
                              ),
                              SizedBox(width: 08.w),
                              Text(
                                  "${data?.provider?.totalReview.toString() ?? "152"} Reviews",
                                  style: textStyele.bodyMedium
                              ),
                            ],
                          ),
                        ),

                        // GridView with safety

                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data?.provider?.specialization?.length ?? 0,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 3/1
                          ),
                          itemBuilder: (context, index) {

                            return AppButton(
                              containerColor: 1,
                              titel: data?.provider?.specialization?[index] ?? "",
                              hight: 40,
                              bodycolor: AppColors.primaryColor,
                              borderColor: AppColors.textSecoundaryColor,
                            );
                          },
                        ),

                        SizedBox(height: 12.h),

                       // Offer price section (unchanged)
                        Stack(
                          children: [
                            Container(
                              height: 94.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.secoundaryColor,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Offered Price\n\$${data?.offerPrice ?? "0"}",
                                    textAlign: TextAlign.center,
                                    style: textStyele.titleLarge!.copyWith(
                                        color: AppColors.primaryColor
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                ],
                              ),
                            ),
                            Positioned(
                              top: -20,
                              left: -20,
                              child: Container(
                                height: 60.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                    color: AppColors.shadoColor.withAlpha(10),
                                    shape: BoxShape.circle
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -25,
                              right: -25,
                              child: Container(
                                height: 66.h,
                                width: 66.w,
                                decoration: BoxDecoration(
                                    color: AppColors.shadoColor.withAlpha(10),
                                    shape: BoxShape.circle
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 24.h),


                        AppButton(
                          titel: "Accept Offer",
                          onPress: () {
                            Get.toNamed(Routes.PAYMENT_DETAILS,arguments: {
                              AppArgumentString.providrId = data?.provider?.id ?? "",
                            });
                          },
                        ),

                        SizedBox(height: 12.h),

                        AppButton(
                          containerColor: 1,
                          titel: "View Profile",
                          bodycolor: AppColors.primaryColor,
                          borderColor: AppColors.secoundaryColor,
                          onPress: () {
                            debugPrint("View Profile id : ${data?.providerId}");
                            SharedPrefHelper.setString(SharedPrefHelper.postMoverId, data?.providerId ?? "");
                            final postMoverId = SharedPrefHelper.getString(SharedPrefHelper.postMoverId);
                            debugPrint("postMoverId: $postMoverId");



                            Get.put(MoverProfielDetailsController());
                            Get.to(() => MoverProfielDetailsView(),
                              arguments: {
                                "bio": "Professional mover with 5 years experience",
                                "name": "Mike James",
                                "rating": "4.5",
                                "reviews": "152",
                                AppArgumentString.providrId: data?.providerId ?? "sdcs",
                              },
                            );
                          },
                        ),


                        SizedBox(height: 24.h),
                      ],
                    ),
                  )
                ],
              ) ;
            },);
        }),
      );
    }

}