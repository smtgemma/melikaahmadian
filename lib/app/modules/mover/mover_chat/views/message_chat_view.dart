import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'package:get/get.dart';

import '../controllers/mover_chat_controller.dart';

class MessageChatView extends StatelessWidget {
  String ? imagepath ;
  String ? name ;
  String ? time ;
  String ? count ;
   MessageChatView({super.key,this.imagepath,this.name,this.time,this.count});

   final controller = Get.put(MoverChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            Spacer(),
            Row(
              children: [
                CircleAvatar(backgroundColor: AppColors.onPrimaryColor,child: Icon(Icons.add),) ,
                SizedBox(width: 12.w,),
                  Expanded(
          child: TextField(
            controller: controller.messageChatController,
            decoration: InputDecoration(
              fillColor: AppColors.cardColor,
              filled: true,
              hintText: "Send Message",
              suffixIcon: GestureDetector(
                onTap: (){
                  controller.messageChatController.clear();
                  debugPrint("send");
                },
                  child: Image.asset(Assets.iconsMessageSend)),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        )


        ],
            ),
            SizedBox(height:24.h ,)

          ],
        ),
      ),
    );
  }
}
