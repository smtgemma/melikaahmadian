import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../routes/app_pages.dart';


class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return  Container(child: Column(
      children: [
        Center(child: Text("Payment Completed",style: textStyele.headlineLarge,textAlign: TextAlign.center,)),
        SizedBox(height: 8.h,),
        Center(child: Text("You’ve successfully paid for the move.",style: textStyele.bodyMedium,)),
        SizedBox(height: 24.h,),
        AppButton(titel: "Back To Home",onPress: (){
          Get.toNamed(Routes.NAVBAR);
        },),
        SizedBox(height: 24.h,),
        AppButton(titel: "Download Receipt",containerColor: 1,)

      ],
    ));
  }
}
