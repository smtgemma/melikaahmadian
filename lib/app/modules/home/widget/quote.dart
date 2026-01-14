import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/network/shared_prepharence_helper.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/modules/home/controllers/home_controller.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'package:get/get.dart';

class Quote extends StatelessWidget {
  bool? ai ;
   Quote({super.key,this.ai});

   final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color:ai == true ? AppColors.cardColor :  AppColors.secoundaryColor,borderRadius: BorderRadius.circular(12.w)),
      child: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ai == true ?  SizedBox(width: 123.w,) : SizedBox() ,
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(color: ai == true ? AppColors.secoundaryColor : AppColors.cardColor,shape: BoxShape.circle),
                child: Center(child: Image.asset(ai == true ? Assets.iconsVideo : Assets.iconsHomeBook),),

              ),
              ai == true ?   SizedBox(width: 60.w,) : SizedBox(),

               ai == true ?  Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 4.h),
                decoration: BoxDecoration(color: AppColors.errorColor,borderRadius: BorderRadius.circular(12.w)),
                child: Text( "Beta",style: textStyele.bodyLarge!.copyWith(color: AppColors.primaryColor,fontSize: 14.sp,fontWeight: FontWeight.bold),),
              ) : SizedBox()
            ],
          ),
          SizedBox(height: 8.h,),
          Text( ai == true ? "Get AI Quote": "Get Manual Quote",style: textStyele.headlineLarge!.copyWith(color:ai == true ? AppColors.secoundaryColor : AppColors.primaryColor),),
          SizedBox(height: 12.h,),
          Text(ai == true ? "AI will generate the movingquote based on the video you post.": "Select the items you want to move & post your request. You will receive offers.",textAlign: TextAlign.center,style: textStyele.bodyMedium!.copyWith(color:ai == true ? AppColors.textSecoundaryColor : AppColors.primaryColor),),
          SizedBox(height: 12.h,),
          AppButton(titel:ai == true ? "Get AI Quote Now" : "Post A Move",containerColor: 1,bodycolor: AppColors.primaryColor,onPress: (){
            if(ai == true){
              SharedPrefHelper.setString(SharedPrefHelper.ai, SharedPrefHelper.ai);
              controller.videoType.value = "ai_video" ;
              Get.toNamed(Routes.VIDEO_CMERA);
            }else{
              controller.videoType.value = "normal_video" ;
              Get.toNamed(Routes.VIDEO_CMERA);
            }
          },)
        ],
      ),


    );
  }
}
