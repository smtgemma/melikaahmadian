import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import '../../../../generated/assets.dart';
import '../../../core/const/app_colors.dart';
import '../views/notification_setting_view.dart';
class Notificationbar extends StatelessWidget {
  const Notificationbar({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side (Text)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notifications",
              style: textStyele.titleMedium,
            ),
            SizedBox(height: 4),
            Text(
              "All your Notifications.",
              style: textStyele.bodyMedium,
            ),
          ],
        ),

        // Right side (Icon)
        InkWell(
          onTap: (){
            Get.to(NotificationSettingView( ));
          },
          child: CircleAvatar(
            backgroundColor: AppColors.onPrimaryColor,
            child: Image.asset(
              Assets.iconsSetting,
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }
}
