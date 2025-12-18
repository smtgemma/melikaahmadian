import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../generated/assets.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/app_back_button.dart';
import '../../../../core/widget/app_background.dart';
import '../../../auth/application_submit/widget/mark_compeleted.dart';
import '../controllers/move_compeleted_controller.dart';
class CompeletedMove extends StatelessWidget {
  const CompeletedMove({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    final compeledted = Get.put(MoveCompeletedController());
    return Scaffold(
      body: AppBackground(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBackButton(),
          SizedBox(height: 82.h,),
          Image.asset(Assets.iconsCongralation),
          SizedBox(height: 24.h,),
          MarkCompeleted(),



        ],
      ),),
    );
  }
}
