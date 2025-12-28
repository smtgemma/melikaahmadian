import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/generated/assets.dart';

import '../../../core/const/app_colors.dart';
import '../controllers/notification_controller.dart';
import '../widget/notificationBar.dart';
import '../widget/notification_item.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBackButton(),
          SizedBox(height: 24.h,),
          Notificationbar(),
          SizedBox(height: 24.h,),
          NotificationItem()

        ],
      ),),
    );
  }
}
