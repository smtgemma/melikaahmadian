import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'package:get/get.dart';
class StatOfDayPosetedMove extends StatelessWidget {
  const StatOfDayPosetedMove({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.cardColor,borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.primaryColor,borderRadius: BorderRadius.circular(8)),
              child: Image.asset(Assets.iconsSun),
            ),
            title: Text("Start Your Day",style: textStyele.titleMedium),
            subtitle: Text("Ready to earn? Let’s go!",style: textStyele.bodyMedium,),


          ),
          SizedBox(height: 24.h,),
          AppButton(titel: "View All Posted Moves",onPress: (){
            Get.toNamed(Routes.MOVER_SEARCH_POST);
          },)
        ],
      ),

    );
  }
}
