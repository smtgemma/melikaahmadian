import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';

import '../../ongoing_mover_details/widget/onging_details.dart';
import '../controllers/cencel_mover_details_controller.dart';

class CencelMoverDetailsView extends GetView<CencelMoverDetailsController> {
  const CencelMoverDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Scaffold(
      body: AppBackground(child:
           SingleChildScrollView(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               AppBackButton(),
               SizedBox(height: 24,),
               Text("Ongoing Moves",style:textStyele.titleLarge,),
               SizedBox(height: 4.h,),
               Text("Details of ongoing moves & mover.",style: textStyele.bodyMedium,),
               SizedBox(height: 24,),
               OngingDetails(isCencel: true,)
             
             
             
             ],),
           )
        ,),
    );
  }
}
