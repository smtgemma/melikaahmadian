import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/const/app_colors.dart';
import 'package:get/get.dart';

import '../controllers/payment_details_controller.dart';
import 'custom_text_filed.dart';
import 'expairy_formeter.dart';
import 'expairy_month_function.dart';

class PaymentMathode extends GetView<PaymentDetailsController> {
  const PaymentMathode({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    final Controller = Get.find<PaymentDetailsController>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.onPrimaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Payment Details", style: textStyele.titleLarge),
            SizedBox(height: 12),
            Divider(),
            SizedBox(height: 12),
            Text("Card Information", style: textStyele.titleMedium),
            SizedBox(height: 4.h),
            CustomPaymentTextField(
              hint: '1234 5678 9012 3456',
              controller: controller.cardNumber,
              validatorMessage: 'Please enter your card number',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                CardNumberInputFormatter(),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomPaymentTextField(
                    hint: 'MM/YY',
                    controller: controller.expDate,
                    validatorMessage: 'Please enter expiry date',
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      ExpiryDateInputFormatter(),
                    ],
                  ),
                ),
                SizedBox(width: 08.w),
                Expanded(
                  child: CustomPaymentTextField(
                    hint: 'CVV',
                    controller: controller.cvcController,
                    validatorMessage: 'Please enter CVV',
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text("Mane on card", style: textStyele.titleMedium),
            SizedBox(height: 4.h),
            CustomPaymentTextField(
              hint: 'Enter Name',
              controller: controller.cardHolderName,
              validatorMessage: 'Please enter card holder name',
              inputFormatters: [],
            ),
            SizedBox(height: 12),
            Text("Country or region", style: textStyele.titleMedium),
            SizedBox(height: 12),
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
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
