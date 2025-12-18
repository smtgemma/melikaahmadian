import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:get/get.dart';

import '../controllers/profile_edit_controller.dart';
class EditBox  extends StatelessWidget {
  const EditBox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileEditController());
    return Row(
      children: [
        Expanded(child: AppButton(containerColor: 1,bodycolor: AppColors.primaryColor,borderColor: AppColors.secoundaryColor,titel: "Cancel",onPress: (){
          controller.setEdit(true) ;
          debugPrint(controller.isEdit.toString());
        },)),
        SizedBox(width: 8.w,),
        Expanded(child: AppButton()),
      ],
    );
  }
}
