import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/widget/App_button.dart';
class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return  Container(
      child: Column(
        children: [
          Center(child:
          Text("Application Submitted",style: textStyele.headlineLarge,textAlign: TextAlign.center,)),
          SizedBox(height: 08.h,),
          Center(child: Text("Your application is under review. You'll be able to provide services after admin approval.",style: textStyele.bodyMedium,textAlign: TextAlign.center,)),
          SizedBox(height: 24.h,),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(color: AppColors.orangeColor.withAlpha(10),borderRadius: BorderRadius.circular(12),border: Border.all(color: AppColors.orangeColor,width: 2)),
            child:Center(child: Text("This usually takes 24-48 hours. We'll notify you once reviewed.",textAlign: TextAlign.center,style: textStyele.bodyMedium!.copyWith(color: AppColors.orangeColor),),),

          ),
          SizedBox(height: 24.h,),
          AppButton(titel: "Done",onPress: (){
            SystemNavigator.pop();
          },)
        ],
      ),
    );
  }
}
