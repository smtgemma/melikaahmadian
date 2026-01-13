import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/modules/mover/mover_chat/controllers/mover_chat_controller.dart';
import 'package:melikaahmadian/app/modules/mover/mover_chat/widget/inbox_person.dart';
import 'message_chat_view.dart';

class MoverChatView extends GetView<MoverChatController> {
  const MoverChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MoverChatController());
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Text("Chat", style: textStyle.titleLarge),
            SizedBox(height: 4.h),
            Text("Messages from the movers.", style: textStyle.bodyMedium),
            SizedBox(height: 24.h),

            /// ---------- Chat List ----------
            Expanded(
              child: Obx(() {
                final model = controller.chatListModel.value;

                // Loading state
                if (model == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Empty list
                if (model.data.isEmpty) {
                  return const Center(child: Text("No conversations yet"));
                }

                // List view
                return RefreshIndicator(
                  onRefresh: controller.refreshChatList,
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 16.h),
                    itemCount: model.data.length,
                    itemBuilder: (context, index) {
                      final chat = model.data[index];
                      final user = chat.otherParticipant;
                      final conversationId = chat.id ?? '';

                      return InboxPersonTile(
                        name: user?.fullName ?? "Unknown",
                        email: user?.email ?? "",
                        role: user?.role ?? "",
                        imageUrl: user?.image,
                        lastMessage:
                            chat.lastMessage?['text'] ?? "No messages yet",
                        onTap: () {
                          Get.to(
                            () => MessageChatView(
                              userId: user?.id,
                              imagePath: user?.image,
                              name: user?.fullName,
                              lastMessage:
                                  chat.lastMessage?['text'] ??
                                  "No messages yet",
                              conversationId: conversationId,
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
