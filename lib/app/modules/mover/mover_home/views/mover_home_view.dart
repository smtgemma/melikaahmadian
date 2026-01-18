import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/app_background.dart';
import '../../../../core/widget/move_post_video.dart';
import '../../../../core/widget/move_status_video.dart';
import '../../../../core/widget/move_video.dart';
import '../../../../core/widget/mover_move_video_status.dart';
import '../../../home/widget/quote.dart';
import '../controllers/mover_home_controller.dart';
import '../widget/stat_of_day_poseted_move.dart';

class MoverHomeView extends GetView<MoverHomeController> {
  const MoverHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: RefreshIndicator(child: AppBackground(child:
      ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h,),
              //name and notification
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("MoveForce",style: textStyele.titleMedium!.copyWith(fontSize: 20.sp),),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.NOTIFICATION);
                    },
                    child: Stack(
                      children: [
                        Icon(Icons.notifications_none_outlined,size: 28,),
                        Positioned(
                          top: 1,
                          right: 0,
                          child: Container(
                            height: 15.h,
                            width: 15.w,
                            decoration: BoxDecoration(color: AppColors.secoundaryColor,shape: BoxShape.circle),
                            child: Center(child: Text("1",style: textStyele.labelLarge!.copyWith(color: AppColors.primaryColor,fontSize: 9,fontWeight: FontWeight.bold),)),

                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.h,),
              StatOfDayPosetedMove(),
              SizedBox(height: 24.h,),
              Text("Upcoming Moves & Updates",style: textStyele.titleMedium,),
              SizedBox(height: 16.h,),
              //MoveStatusVideo(),

              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secoundaryColor,
                    ),
                  );
                }

                final data = controller.postItems;

                if (data.isEmpty) {
                  return Center(
                    child: Text(
                      "No Moves Found",
                      style: textStyele.titleMedium,
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];

                    String formattedDate = (item.createdAt ?? "").split("T").first;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: MoverMoveStatusVideo(
                        isOffer: true,
                        postId: item.id,
                        videoUrl: item.media?.isNotEmpty == true
                            ? item.media!.first.url
                            : null,
                        from: item.dropoffAddress?.address ?? "",
                        to: item.pickupAddress?.address ?? "",
                        date: formattedDate,
                        isNavigator: true,
                        titel:  "Offer",
                       // color: _statusBgColor(item.status),
                        //textColor: _statusTextColor(item.status),
                        isType: item.status ?? "",
                      ),
                    );
                  },
                );
              })
             // SafeMoveVideo()
              //MoveVideo()



            ],

          )
        ],
      )
      ), onRefresh: (){
        return controller.getMoves();
      }),

    );
  }
}
