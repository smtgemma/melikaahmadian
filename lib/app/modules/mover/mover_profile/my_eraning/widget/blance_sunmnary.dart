import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
class BlanceSunmnary extends StatelessWidget {
  String ? totalmove ;
  String ? totacommison ;
  String ? totalbalance ;

  BlanceSunmnary({super.key,this.totalmove,this.totacommison,this.totalbalance});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.cardColor,borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Blance Summary",style: textStyele.titleLarge,),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total completed move",style: textStyele.bodyMedium,),
              Text( "\$$totalmove"?? "0",style: textStyele.titleMedium,),




            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Company Commission",style: textStyele.bodyMedium,),
              Text( "\$$totacommison"?? "0",style: textStyele.titleMedium,),




            ],
          ),
          SizedBox(height: 12.h),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Net Total",style: textStyele.titleLarge,),
              Text( "\$$totacommison"?? "0",style: textStyele.titleMedium,),




            ],
          ),





        ],
      ),
    );
  }
}
