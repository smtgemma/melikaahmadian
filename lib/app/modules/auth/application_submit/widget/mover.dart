import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../routes/app_pages.dart';
class Mover extends StatelessWidget {
  const Mover({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return  Container(child: Column(
      children: [
        Center(child: Text("Move Posted",style: textStyele.headlineLarge,textAlign: TextAlign.center,)),
        SizedBox(height: 8.h,),
        Center(child: Text("Someone will Pickup your move in no time.",style: textStyele.bodyMedium,)),
        SizedBox(height: 24.h,),
        AppButton(titel: "Back To Home",onPress: (){
          Get.toNamed(Routes.NAVBAR);
        },)

      ],
    ));

  }
}
