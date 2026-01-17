import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'package:get/get.dart';
import '../controllers/mover_chat_controller.dart';

class MessageChatView extends StatefulWidget {
  final String? imagePath;
  final String? name;
  final String? lastMessage;
  final String conversationId;
  final String? userId;

  const MessageChatView({
    super.key,
    this.imagePath,
    this.name,
    this.lastMessage,
    required this.conversationId, this.userId,
  });

  @override
  State<MessageChatView> createState() => _MessageChatViewState();
}

class _MessageChatViewState extends State<MessageChatView> {
  late MoverChatController controller;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<MoverChatController>();
    scrollController = ScrollController();

    // Join conversation when view is opened
    controller.joinConversation(widget.conversationId);

    // Auto-scroll when new messages arrive
    controller.messages.listen((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSendMessage() {
    final text = controller.messageChatController.text.trim();
    if (text.isEmpty) return;

    controller.sendMessage(text);
    controller.setTyping(false);
  }

  @override
  void dispose() {
    controller.leaveConversation();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with user info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBackButton(),
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundImage: widget.imagePath != null
                            ? NetworkImage(widget.imagePath!)
                            : null,
                        child: widget.imagePath == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name ?? "Unknown",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Obx(() {
                              final onlineCount = controller.onlineUsers.length;
                              final isConnected =
                                  controller.isSocketConnected.value;
                              return Text(
                                isConnected
                                    ? (onlineCount > 0
                                          ? '$onlineCount online'
                                          : 'Online')
                                    : 'Connecting...',
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: isConnected
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.AUDIO_CALL,arguments: {
                      'userId': widget.userId,
                    });
                  },
                  icon: const Icon(Icons.call),
                ),
              ],
            ),
            Divider(height: 1.h),
            SizedBox(height: 12.h),

            // Messages List
            Expanded(
              child: Obx(() {
                if (controller.messages.isEmpty) {
                  return Center(
                    child: Text(
                      'No messages yet. Start a conversation!',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }

                return ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    // You might need to adjust 'senderId' based on your actual data structure
                    final isSentByMe = message['senderId'] == 'YOUR_USER_ID';

                    return Align(
                      alignment: isSentByMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSentByMe
                              ? AppColors.onPrimaryColor
                              : AppColors.cardColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          crossAxisAlignment: isSentByMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Message text
                            Text(
                              message['text'] ?? '',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: isSentByMe
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                            ),

                            // Message image
                            if (message['image'] != null)
                              Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.network(
                                    message['image'],
                                    width: 150.w,
                                    height: 150.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                            // Timestamp
                            Padding(
                              padding: EdgeInsets.only(top: 4.h),
                              child: Text(
                                _formatTime(message['timestamp']),
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: isSentByMe
                                          ? Colors.white70
                                          : Colors.grey,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            // Typing indicator
            Obx(() {
              if (controller.isTyping.value) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    'Someone is typing...',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            SizedBox(height: 8.h),

            // Chat input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.onPrimaryColor,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextField(
                      controller: controller.messageChatController,
                      onChanged: (value) {
                        controller.setTyping(value.isNotEmpty);
                      },
                      decoration: InputDecoration(
                        fillColor: AppColors.cardColor,
                        filled: true,
                        hintText: "Send Message",
                        suffixIcon: GestureDetector(
                          onTap: _handleSendMessage,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset(Assets.iconsMessageSend),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  String _formatTime(dynamic timestamp) {
    try {
      if (timestamp is String) {
        final dateTime = DateTime.parse(timestamp);
        return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
      } else if (timestamp is int) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
      }
    } catch (e) {
      return '';
    }
    return '';
  }
}
