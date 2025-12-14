import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../controllers/document_uplod_page_controller.dart';
import '../widget/document_featur.dart';

class DocumentUplodPageView extends GetView<DocumentUplodPageController> {
  const DocumentUplodPageView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBackButton(),
          SizedBox(height: 130.h,),
          Text("Verification Required",style: textStyele.headlineLarge,),
          SizedBox(height: 8.h,),
          Text("To start providing moving services, we need to verify your documents and vehicle.",style: textStyele.bodyMedium,),
          SizedBox(height: 24.h,),
          DocumentFeatur(),
          SizedBox(height: 24.h,),
         AppButton(titel: "Start Verification",onPress: (){Get.toNamed(Routes.DOCUMENT_UPLOD);},)

        ],
      ),),
    );
  }
}
