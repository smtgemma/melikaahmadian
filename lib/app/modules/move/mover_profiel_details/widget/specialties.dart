import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';

class Specialties extends StatelessWidget {
  final List<String> specialties;

  Specialties({super.key, this.specialties = const []}); // default empty list

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Container(
      decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Specialties", style: textStyele.titleLarge),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: specialties.length ?? 5,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 3 / 1,
            ),
            itemBuilder: (context, index) {
              var item = specialties[index]; // now it's a String
              return AppButton(
                containerColor: 1,
                titel: item,
                hight: 40,
                bodycolor: AppColors.primaryColor,
                borderColor: AppColors.textSecoundaryColor,
              );
            },
          ),
        ],
      ),
    );
  }
}

