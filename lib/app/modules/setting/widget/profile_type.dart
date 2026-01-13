import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_image_frame_radious_widget.dart';

import '../../../../generated/assets.dart';

class ProfileType extends StatelessWidget {
  String? titel ;
  String? profileImage ;
  String? subtitel ;
  VoidCallback? onpress ;
  bool? isProfile ;
  String? iconPath ;
  Color? textcolor ;
   ProfileType({super.key,this.titel,this.profileImage,this.subtitel,this.onpress,this.isProfile,this.iconPath,this.textcolor});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Column(
      children: [
        Container(
         // height: 70.h,
          padding: EdgeInsets.all( isProfile == true ? 0.w : 07.w),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: isProfile == true ? ListTile(
            leading: AppImageFrameRadiousWidget(),
            title: Text( titel ?? "Mike James",style: textStyele.titleMedium,),
            subtitle: Text( subtitel ?? "My profile",style: textStyele.bodyMedium!.copyWith(fontSize: 14)),
            trailing: InkWell(
                onTap: onpress,
                child: Icon(Icons.arrow_forward_ios,color: AppColors.secoundaryColor,)),
          ) : ListTile(
            leading: CircleAvatar(child: Center(child: Image.asset(iconPath ?? Assets.iconsPassword  )),backgroundColor: AppColors.primaryColor,),
            title: Text( titel ?? "Change Password",style: textStyele.titleMedium!.copyWith(color: textcolor),),
            trailing: InkWell(
                onTap: onpress,
                child: Icon(Icons.arrow_forward_ios,color: AppColors.secoundaryColor,)),
          ),
        ),
        SizedBox(height: 12.h,)
      ],
    );
  }
}
