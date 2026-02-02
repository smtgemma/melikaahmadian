import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';

import '../../../../../core/widget/app_back_button.dart';
import '../../../../../core/widget/app_background.dart';
import '../controllers/mover_account_controller.dart';

class MoverAccountView extends GetView<MoverAccountController> {
  const MoverAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Set Account",
                style: textStyle.titleLarge,
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // INTERAC Section
                    _buildPaymentMethodCheckbox(
                    title: "INTERAC",
                    value: controller.selectedMethod.value == 'INTERAC',
                    onChanged: (value) {
                      controller.togglePaymentMethod('INTERAC');
                    },
                  ),
                      if (controller.selectedMethod.value == 'INTERAC')
                        _buildInteracFields(textStyle),

                      SizedBox(height: 16.h),

                      // BANK_EFT Section
                      _buildPaymentMethodCheckbox(
                        title: "BANK EFT",
                        value: controller.selectedMethod.value == 'BANK_EFT',
                        onChanged: (value) {
                          controller.togglePaymentMethod('BANK_EFT');
                        },
                      ),
                      if (controller.selectedMethod.value == 'BANK_EFT')
                        _buildBankEftFields(textStyle),

                      SizedBox(height: 16.h),

                      // WALLET Section
                      _buildPaymentMethodCheckbox(
                        title: "WALLET",
                        value: controller.selectedMethod.value == 'WALLET',
                        onChanged: (value) {
                          controller.togglePaymentMethod('WALLET');
                        },
                      ),
                      if (controller.selectedMethod.value == 'WALLET')
                        _buildWalletFields(textStyle),

                      SizedBox(height: 32.h),

                      // Submit Button
                      SizedBox(height: 32.h),

// Submit Button
                      if (controller.selectedMethod.value.isNotEmpty)
                        SizedBox(
                          width: double.infinity,
                          child: Obx(() => AppButton(
                            onPress: () {
                              controller.submitPaymentMethod();
                            },
                            titel: "Save Payment Method",
                            isLoding: controller.isSaving.value,
                          )),
                        ),
                      SizedBox(height: 24.h),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCheckbox({
    required String title,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: value ? Colors.blue : Colors.grey.shade300,
          width: value ? 2 : 1,
        ),
      ),
      child: CheckboxListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  Widget _buildInteracFields(TextTheme textStyle) {
    return Container(
      margin: EdgeInsets.only(top: 12.h, left: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: "Email",
            controller: controller.interacEmailController,
            hint: "provider@example.com",
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            label: "Security Question",
            controller: controller.interacSecurityQuestionController,
            hint: "What is your pet's name?",
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            label: "Security Answer",
            controller: controller.interacSecurityAnswerController,
            hint: "Fluffy",
          ),
        ],
      ),
    );
  }

  Widget _buildBankEftFields(TextTheme textStyle) {
    return Container(
      margin: EdgeInsets.only(top: 12.h, left: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: "Bank Name",
            controller: controller.bankNameController,
            hint: "Royal Bank of Canada",
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            label: "Account Number",
            controller: controller.accountNumberController,
            hint: "123456789",
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            label: "Routing Number",
            controller: controller.routingNumberController,
            hint: "003",
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            label: "Account Holder Name",
            controller: controller.accountHolderNameController,
            hint: "John Doe",
          ),
        ],
      ),
    );
  }

  Widget _buildWalletFields(TextTheme textStyle) {
    return Container(
      margin: EdgeInsets.only(top: 12.h, left: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: "Wallet Type",
            controller: controller.walletTypeController,
            hint: "PAYPAL",
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            label: "Wallet ID",
            controller: controller.walletIdController,
            hint: "john.doe@paypal.com",
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            label: "Email",
            controller: controller.walletEmailController,
            hint: "john.doe@paypal.com",
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }
}