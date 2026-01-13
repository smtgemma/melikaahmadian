import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:get/get.dart';

import '../controllers/payment_details_controller.dart';
class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

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
          SizedBox(height: 12.h,),
          Divider(),
          SizedBox(height: 12.h,),
          Text("First name",style: textStyele.titleMedium),
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
          SizedBox(height: 12.h,),
          Text("Last name",style: textStyele.titleMedium),
          SizedBox(height: 4.h,),
          TextField(
            controller: Controller.lastNameController,
            cursorHeight: 20,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryColor,
              hintText: "Last name",
              hintStyle: textStyele.bodyMedium,

            ),
          ),
          SizedBox(height: 12.h,),
          Text("Phone",style: textStyele.titleMedium),
          SizedBox(height: 4.h,),
          TextField(
            keyboardType: TextInputType.phone,
            controller: Controller.phoneNumberController,
            cursorHeight: 20,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryColor,
              hintText: "Phone",
              hintStyle: textStyele.bodyMedium,

            ),
          ),
          SizedBox(height: 12.h,),
          Text("Email",style: textStyele.titleMedium),
          SizedBox(height: 4.h,),
          TextField(
            controller: Controller.emailController,
            cursorHeight: 20,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryColor,
              hintText: "Email",
              hintStyle: textStyele.bodyMedium,

            ),
          ),
          SizedBox(height: 12.h,),
          Text("Country",style: textStyele.titleMedium),
          SizedBox(height: 4.h,),
          TextField(
            controller: Controller.countryController,
            cursorHeight: 20,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryColor,
              hintText: "Country",
              hintStyle: textStyele.bodyMedium,

            ),
          ),
          SizedBox(height: 12.h,),
          Text("Address",style: textStyele.titleMedium),
          SizedBox(height: 4.h,),
          TextField(
            controller: Controller.addressController,
            cursorHeight: 20,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryColor,
              hintText: "Address",
              hintStyle: textStyele.bodyMedium,

            ),
          ),
          SizedBox(height: 12.h,),
          TextField(
            controller: Controller.StateaddressController,
            cursorHeight: 20,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryColor,
              hintText: "State",
              hintStyle: textStyele.bodyMedium,

            ),
          ),
          SizedBox(height: 12.h,),
          TextField(
            controller: Controller.zipaddressController,
            cursorHeight: 20,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryColor,
              hintText: "Zip code",
              hintStyle: textStyele.bodyMedium,

            ),
          ),



        ],
          ),
    );
  }
}
