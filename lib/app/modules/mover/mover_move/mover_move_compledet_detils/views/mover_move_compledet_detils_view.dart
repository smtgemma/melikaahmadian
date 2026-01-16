import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../../core/widget/app_back_button.dart';
import '../../mover_move_detils/widget/mover_move_detils.dart';
import '../controllers/mover_move_compledet_detils_controller.dart';

class MoverMoveCompledetDetilsView
    extends GetView<MoverMoveCompledetDetilsController> {
  const MoverMoveCompledetDetilsView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 24.h,),
              Text("${controller.moveType} Move Details",style:textStyele.titleLarge,),
              SizedBox(height: 4.h,),
              Text("Details of a particular move.",style: textStyele.bodyMedium,),
              SizedBox(height: 24,),
              MoverMoveDetils()
          
            ],
          ),
        ),
      ),
    );
  }
}
