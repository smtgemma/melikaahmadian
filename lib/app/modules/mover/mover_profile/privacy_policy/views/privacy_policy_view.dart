import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../../core/const/app_colors.dart';
import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: RefreshIndicator(child:  AppBackground(
        child: Obx(() => controller.isLoading.value == true ? Center(child: CircularProgressIndicator(color: AppColors.secoundaryColor,),) :
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 24.h,),
              Text("Privacy Policy",style: TextTheme.of(context).titleLarge,),
              SizedBox(height: 04.h,),
              Text("Privacy policy of out platform.",style: TextTheme.of(context).bodyMedium,),
              SizedBox(height: 12.h,),
              Obx(() =>   MarkdownBody(data: controller.tos.value ?? "No data found"),)










            ],
          ),
        ),),
      ), onRefresh: (){
        controller.privacyPolicy();
        return Future.delayed(Duration(seconds: 1));
      }),
    );
  }
}
