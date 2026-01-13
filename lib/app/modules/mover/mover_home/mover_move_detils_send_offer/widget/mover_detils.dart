import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../core/const/app_argument_string.dart';
import '../../../../../core/const/app_colors.dart';
import '../../../../../core/widget/App_button.dart';
import '../../../../../core/widget/move_video.dart';
import '../../../../home/custom_furniture/widget/produc_countity.dart';
import '../../../../move/offer_review/widget/single_information.dart';
import '../controllers/mover_move_detils_send_offer_controller.dart';
class MoverDetils extends StatelessWidget {
  const MoverDetils({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MoverMoveDetilsSendOfferController());
    var textStyele = TextTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MoveVideo(),
        SizedBox(height: 24.h),
        SingleInformation(isChild: true, titel: "Toronto, Canada"),
        SizedBox(height: 12.h),
        SingleInformation(
          isChild: true,
          titel: "Toronto, Canada",
          iconPath: Assets.iconsFrom,
        ),
        SizedBox(height: 24.h),
        Text("Time Details", style: textStyele.titleLarge),
        SizedBox(height: 12.h),
        SingleInformation(
          isChild: true,
          titel: "27th November 2025",
          iconPath: Assets.iconsCalender,
        ),
        SizedBox(height: 12.h),
        SingleInformation(
          isChild: true,
          titel: "10:30 AM",
          iconPath: Assets.iconsQuite,
        ),
        SizedBox(height: 24.h),
        Text("Selected House Type", style: textStyele.titleLarge),
        SizedBox(height: 12.h),
        SingleInformation(titel: "House"),
        SizedBox(height: 24.h),
        Text("Selected Furnitures", style: textStyele.titleLarge),
        SizedBox(height: 12.h),
        ProducCountity(isReview: true),
        Text("Send Your Offer Price", style: textStyele.titleLarge),
        SizedBox(height: 04.h),
        Text("Send an custom offer to the client.", style: textStyele.bodyMedium),
        SizedBox(height: 12.h),
        Container(
          height: 52.h,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.cardColor,borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Container(
                  height: double.infinity,
                  width: 54.w,
                  decoration: BoxDecoration(color: AppColors.secoundaryColor,borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r),bottomLeft: Radius.circular(12.r))),
                  child: Center(child: Text("\$",style: textStyele.headlineLarge!.copyWith(color: AppColors.primaryColor),),)),
              Expanded(
                child: TextField(
                  controller: controller.priceEditinController,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.secoundaryColor,
                  cursorHeight: 20.h,
                  decoration: const InputDecoration(
                    hintText: "Write your offer price",
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              )

            ],
          ),
        ),
        SizedBox(height: 24.h),

        AppButton(
          titel: "Send This Offer",
          onPress: () {
            Get.toNamed(Routes.APPLICATION_SUBMIT,arguments: {
              AppArgumentString.moverSendOffer : AppArgumentString.moverSendOffer
            });

          },
        ),

        SizedBox(height: 24.h),
      ],
    );
  }
}
