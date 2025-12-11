import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../../../core/widget/App_button.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/bio_controller.dart';

class BioView extends GetView<BioController> {
   BioView({super.key});
   final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(

      body: AppBackground(
        child: Column(
          children: [
            Form(
                key: _globalKey,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBackButton(),
                SizedBox(height: 24,),
                Text("Write a Short Bio",style: textStyele.headlineLarge,),
                SizedBox(height: 8,),
                Text("Tell us more about yourself.",style: textStyele.bodyMedium,),
                SizedBox(height: 8,),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Bio is required";
                    }
                    return null;
                  },
                  cursorHeight: 20,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "The mover completed his move in a very organized way. Recommended."
                  ),
                ),
                SizedBox(height: 24,),
                AppButton(titel: "Continue",onPress: (){
                  if(_globalKey.currentState!.validate()){
                    Get.toNamed(Routes.SPECIALTY);

                  }return null ;

                },)

              ],
            ))
          ],
        ),
      ),

    );
  }
}
