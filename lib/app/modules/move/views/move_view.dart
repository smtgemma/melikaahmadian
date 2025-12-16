import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/widget/move_status_video.dart';
import 'package:melikaahmadian/app/modules/home/custom_furniture/widget/catagory.dart';

import '../../../core/widget/move_video.dart';
import '../controllers/move_controller.dart';

class MoveView extends GetView<MoveController> {
  const MoveView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h,),
            Text("My Moves",style: textStyele.titleLarge,),
            SizedBox(height: 04.h,),
            Text("All your moves at one place",style: textStyele.bodyMedium,),
            SizedBox(height: 24.h,),
            Catagory(),
            MoveStatusVideo(isNavigator: true,)

          ],
        ),
      ),
    );
  }
}
