import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../generated/assets.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h,),
        InkWell(
          onTap: (){
            Get.back();
          },
          child: SizedBox(
            child:  Image.asset(Assets.iconsBack),
          ),
        ),
      ],
    );
  }
}
