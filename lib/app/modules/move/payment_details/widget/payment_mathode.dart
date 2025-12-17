import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/const/app_colors.dart';
import 'package:get/get.dart';

import '../controllers/payment_details_controller.dart';

class PaymentMathode extends StatelessWidget {
  const PaymentMathode({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    final Controller = Get.find<PaymentDetailsController>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.onPrimaryColor,borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment Details",style: textStyele.titleLarge),
          SizedBox(height: 12,),
          Divider(),
          SizedBox(height: 12,),
          Text("Card Information",style: textStyele.titleMedium),
          SizedBox(height: 4.h,),
          TextField(
            controller: Controller.firstNameController,
            cursorHeight: 20,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryColor,
              hintText: "First name",
              hintStyle: textStyele.bodyMedium,
            ),
          ),
          SizedBox(height: 12,),
          Row(
            children: [
              Expanded(child: TextField(
                controller: Controller.mmCardController,
                cursorHeight: 20,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.primaryColor,
                  hintText: "MM/YY",
                  hintStyle: textStyele.bodyMedium,
                ),
              ),),
              SizedBox(width: 08.w,),
              Expanded(child: TextField(
                controller: Controller.cvcCardController,
                cursorHeight: 20,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.primaryColor,
                  hintText: "CVC",
                  hintStyle: textStyele.bodyMedium,
                ),
              ),)

            ],
          ),
          SizedBox(height: 12,),
          Text("Mane on card",style: textStyele.titleMedium),
          SizedBox(height: 4.h,),
          TextField(
            controller: Controller.aledMeanCardController,
            cursorHeight: 20,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryColor,
              hintText: "First name",
              hintStyle: textStyele.bodyMedium,
            ),
          ),
          SizedBox(height: 12,),
          Text("Country or region",style: textStyele.titleMedium),
          SizedBox(height: 12,),
          TextField(
            controller: Controller.countryOrRegonController,
            cursorHeight: 20,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryColor,
              hintText: "01001",
              hintStyle: textStyele.bodyMedium,
            ),
          ),
          SizedBox(height: 12,),







        ],
      ),
    );
  }
}
