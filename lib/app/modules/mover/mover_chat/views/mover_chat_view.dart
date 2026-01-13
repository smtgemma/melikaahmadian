import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/modules/audio_call/controllers/audio_call_controller.dart';

import '../controllers/mover_chat_controller.dart';
import '../widget/inbox_person.dart';

class MoverChatView extends GetView<MoverChatController> {
  const MoverChatView({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Text("Chat", style: textStyele.titleLarge),
            SizedBox(height: 04.h),
            Text("Messages from the movers.", style: textStyele.bodyMedium),
            SizedBox(height: 24.h),
            InboxPerson(),
          ],
        ),
      ),
    );
  }
}
