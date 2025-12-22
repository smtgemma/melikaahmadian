import 'package:flutter/material.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:get/get.dart';
import '../../../../core/widget/app_image_frame_radious_widget.dart';
import '../views/message_chat_view.dart';
class InboxPerson extends StatelessWidget {
  String ? imagepath ;
  String ? name ;
  String ? time ;
  String ? count ;

   InboxPerson({super.key,this.imagepath,this.name,this.time,this.count});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return ListTile(
      onTap: (){
        Get.to(MessageChatView());
      },
      title: Text(name ?? "Mike James",style: textStyele.titleMedium,),
      leading: AppImageFrameRadiousWidget(radious: 30,),
      subtitle: Text("Hello, how are you?",style: textStyele.bodyMedium,),
      trailing: CircleAvatar(
        backgroundColor: AppColors.onPrimaryColor,
        child: Text(count ?? "2",style: textStyele.bodyMedium!.copyWith(color: AppColors.errorColor,fontWeight: FontWeight.bold),),),


    );
  }
}
