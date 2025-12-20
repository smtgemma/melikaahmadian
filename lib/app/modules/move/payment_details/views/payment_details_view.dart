import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/modules/move/offer_review/widget/detils.dart';

import '../../../../core/const/app_argument_string.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/payment_details_controller.dart';
import '../widget/payment_details.dart';
import '../widget/payment_mathode.dart';

class PaymentDetailsView extends GetView<PaymentDetailsController> {
  const PaymentDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 24,),
              PaymentDetails(),
              SizedBox(height: 24,),
              PaymentMathode(),
              SizedBox(height: 24,),
              AppButton(titel: "Pay Now",onPress: (){
                Get.toNamed(Routes.APPLICATION_SUBMIT,arguments: {
                  AppArgumentString.payment : AppArgumentString.payment
                });
              },),
              SizedBox(height: 24,),

          
            ],
          ),
        ),
      ),


    );
  }
}
