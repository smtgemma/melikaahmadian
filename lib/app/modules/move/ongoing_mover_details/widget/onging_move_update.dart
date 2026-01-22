import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'package:get/get.dart';
import '../../../../core/const/app_argument_string.dart';
import '../../../../core/const/app_colors.dart';
import '../repository/ongoing_profile_details_repository.dart';
import '../views/compeleted_move.dart';

class OngingMoveUpdate extends StatelessWidget {
  String? id ;
  String? status ;

   OngingMoveUpdate({super.key,this.id,this.status});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: AppColors.cardColor,borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(Assets.iconsMessageSend),
              SizedBox(height: 4.h,),
              Text(status == "NOT_STARTED" ? "On The Way To The Pickup Location" : status == "NOT_STARTED" ? "ON_WAY_TO_PICKUP" : status == "REACHED_PICKUP"  ? "Reached The Pickup Location" : status == "ON_WAY_TO_DROPOFF" ? "On The way To Dropoff Location" : status == "REACHED_DROPOFF" ? "Reached The Dropoff Location" : "Mark As completed Move"  ,style: textStyele.titleMedium,),
              SizedBox(height: 4.h,),
            ],
          ),
         ),
        SizedBox(height: 24.h,),
        AppButton(titel: "Mark As completed Move",child: true,iconPath: Assets.iconsRoundTik,
          onPress: (){
          bottomSheet(context,id: id);
        },)
      ],
    );
  }
  void bottomSheet(BuildContext context,{String? id}) {
    var textStyele = TextTheme.of(context);
    showModalBottomSheet(context: context, builder: (context) {
      return  Container(
        height: 251.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(color: AppColors.primaryColor,borderRadius:BorderRadius.only(topLeft: Radius.circular(24.w),topRight: Radius.circular(24.w))),
        child: Column(
          children: [
            Text("Do you want to mark the move ascompleted?",textAlign: TextAlign.center,style: textStyele.titleMedium,),
            SizedBox(height: 12.h,),
            AppButton(titel: "Yes, Mark As Completed",onPress: (){
              OngoingProfileDetailsRepository.compeletedMove(id: id);
           //   Get.to(CompeletedMove());
            },),
            SizedBox(height: 12.h,),
            AppButton(titel: "No, Don’t Mark As Completed",containerColor: 1,onPress: (){Get.back();},)
          ],
        ),

      );
    },) ;

  }
}
