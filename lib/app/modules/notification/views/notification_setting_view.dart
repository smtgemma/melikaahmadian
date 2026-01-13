import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:get/get.dart';
import '../../../core/const/app_colors.dart';
import '../controllers/notification_controller.dart';

class NotificationSettingView extends StatelessWidget {
  const NotificationSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 24.h,),
            Text("Notification Setting",style: textStyele.titleLarge,),
            SizedBox(height: 04.h,),
            Text("Set your notification Preference.",style: textStyele.bodyMedium,),
            SizedBox(height: 24.h,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
              decoration: BoxDecoration(color: AppColors.cardColor,borderRadius: BorderRadius.circular(12),border: Border.all(color: AppColors.strtoColor)),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Push Notification",style: textStyele.titleMedium,),
                 Obx(() =>  Switch(
                     activeTrackColor: AppColors.textSecoundaryColor,
                     value: controller.isSwitched.value, onChanged: (value){
                   controller.switchValue(value: value);
                 }),)
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
