import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';

class Specialties extends StatelessWidget {
  const Specialties({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Container(
      decoration: BoxDecoration(color: AppColors.cardColor,borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Specialties",style: textStyele.titleLarge,),
          SizedBox(height: 12.h,),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 3/1

            ), itemBuilder: (context, index) {
            return AppButton(containerColor: 1,titel: "Heavy Items",hight: 40,bodycolor: AppColors.primaryColor,borderColor: AppColors.textSecoundaryColor,);
          },),

        ],),

    );
  }
}
