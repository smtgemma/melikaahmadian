import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../controllers/mover_move_detils_send_offer_controller.dart';
import '../widget/mover_detils.dart';

class MoverMoveDetilsSendOfferView
    extends GetView<MoverMoveDetilsSendOfferController> {
  const MoverMoveDetilsSendOfferView({super.key});
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
              Text("Move Details",style: textStyele.titleLarge,),
              SizedBox(height: 4.h,),
              Text("Details of a particular move.",style: textStyele.bodyMedium,),
              MoverDetils(),
              SizedBox(height: 12.h,),
            ],
          ),
        ),
      )
    );
  }
}
