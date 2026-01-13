import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/App_button.dart';
import '../../../../routes/app_pages.dart';
class MoverSendOffer extends StatelessWidget {
  const MoverSendOffer({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return  Container(
      child: Column(
        children: [
          Center(child:
          Text("Successfully Sent.",style: textStyele.headlineLarge,textAlign: TextAlign.center,)),
          SizedBox(height: 08.h,),
          Center(child: Text("Offer sent, we will let you know if the client accepts your offer.",style: textStyele.bodyMedium,textAlign: TextAlign.center,)),
          SizedBox(height: 24.h,),
          SizedBox(height: 24.h,),
          AppButton(titel: "Back To Home",onPress: (){

            Get.toNamed(Routes.MOVER_NAVBAR);

          },)
        ],
      ),
    );
  }
}
