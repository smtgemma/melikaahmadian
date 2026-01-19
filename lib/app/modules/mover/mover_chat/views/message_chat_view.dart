import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';
import '../controllers/mover_chat_controller.dart';

class MessageChatView extends StatefulWidget {
  final String? imagePath;
  final String? name;
  final String? conversationId;
  final String? userId;

  const MessageChatView({
    super.key,
    this.imagePath,
    this.name,
    this.conversationId,
    this.userId,
  });

  @override
  State<MessageChatView> createState() => _MessageChatViewState();
}

class _MessageChatViewState extends State<MessageChatView>
    with SingleTickerProviderStateMixin {
  late MoverChatController controller;
  late ScrollController scrollController;
  late AnimationController animationController;
  final _networkCaller = DioClient();
  int _page = 1;
  final int _limit = 20;
  bool _isFetching = false;
  final isLoadingMessages = false.obs;
  final hasMoreMessages = true.obs;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<MoverChatController>()) {
      controller = Get.find<MoverChatController>();
    } else {
      controller = MoverChatController();
    }

    controller.currentConversationId.value = widget.conversationId ?? '';
    // controller = Get.find<MoverChatController>();
    scrollController = ScrollController();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    /// 1️⃣ Join socket room FIRST
    controller.joinChat(widget.conversationId ?? '');

    /// 2️⃣ Load old messages (after next frame so ScrollController can attach)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchMessageHistory(widget.conversationId ?? '');

      /// Add pagination listener after controller is ready
      scrollController.addListener(_paginationListener);
    });

    /// 3️⃣ Auto scroll on new message (NEW messages from socket)
    controller.messages.listen((messages) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    });

    /// Start typing animation
    animationController.repeat();
  }

  void _paginationListener() {
    // Trigger pagination when user scrolls to top
    if (scrollController.position.pixels <=
        scrollController.position.minScrollExtent + 50) {
      if (!_isFetching && hasMoreMessages.value) {
        fetchMessageHistory(widget.conversationId ?? '', loadMore: true);
      }
    }
  }

  Future<void> fetchMessageHistory(
    String conversationId, {
    bool loadMore = false,
  }) async {
    if (_isFetching || (!hasMoreMessages.value && loadMore)) return;

    try {
      _isFetching = true;
      isLoadingMessages.value = true;

      if (loadMore) _page++;

      final response = await _networkCaller.get(
        AppUrls.getMyChatList(conversationId, _page, _limit),
      );

      if (response.statusCode == 200) {
        final List list = response.data['data'] ?? [];

        if (list.isEmpty) {
          hasMoreMessages.value = false;
          return;
        }

        // 🔹 REVERSE the list so newest messages are at bottom
        final reversedList = list.reversed.toList();

        final newMessages = reversedList.map((e) {
          return MessageModel.fromJson(
            e,
            e['senderId'] == controller.currentUserId.value,
            controller.currentUserId.value,
          );
        }).toList();

        // 🔹 Only adjust scroll position if loading MORE (pagination)
        if (loadMore && scrollController.hasClients) {
          final previousContentHeight =
              scrollController.position.maxScrollExtent;

          // ⬆️ Insert old messages at top (oldest first)
          controller.messages.insertAll(0, newMessages);

          // 🔹 After building, restore scroll position
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients) {
              final newContentHeight =
                  scrollController.position.maxScrollExtent;
              final heightDifference = newContentHeight - previousContentHeight;

              scrollController.jumpTo(
                scrollController.position.pixels + heightDifference,
              );
            }
          });
        } else {
          // First load - add messages in correct order and scroll to bottom
          controller.messages.addAll(newMessages);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });
        }

        log('✅ Loaded ${newMessages.length} messages (newest at bottom)');
      }
    } catch (e) {
      log('❌ Message history error: $e');
      Get.snackbar('Error', 'Failed to load message history');
    } finally {
      _isFetching = false;
      isLoadingMessages.value = false;
    }
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
    controller.leaveChat();
    scrollController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            // Modern Header
            _buildHeader(),
            // Divider(height: 1.h),

            // Messages List
            Expanded(
              child: Obx(() {
                if (controller.messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isLoadingMessages.value
                            ? Center(child: CircularProgressIndicator())
                            : Column(
                                children: [
                                  Icon(
                                    Icons.chat_bubble_outline,
                                    size: 60.sp,
                                    color: Colors.grey[400],
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'No messages yet',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: Colors.grey[600]),
                                  ),

                                  SizedBox(height: 8.h),
                                  Text(
                                    'Start a conversation!',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey[500]),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  );
                }

                return Stack(
                  children: [
                    ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        final showDateDivider =
                            index == 0 ||
                            _shouldShowDateDivider(
                              controller.messages[index - 1],
                              message,
                            );

                        return Column(
                          children: [
                            if (showDateDivider) ...[
                              _buildDateDivider(message.timestamp),
                              SizedBox(height: 12.h),
                            ],
                            _buildMessageBubble(message),
                          ],
                        );
                      },
                    ),
                    // Loading indicator at top
                    if (isLoadingMessages.value)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8.h),
                          child: Center(
                            child: SizedBox(
                              width: 24.w,
                              height: 24.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),

            // Typing Indicator
            Obx(() {
              if (controller.isTyping.value) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    children: [
                      _buildTypingIndicator(),
                      SizedBox(width: 8.w),
                      Text(
                        '${controller.typingUserName.value} is typing...',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox(height: 8.h);
            }),

            // Input Area
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Row(
        children: [
          AppBackButton(),
          SizedBox(width: 12.w),
          // Avatar with online indicator
          Stack(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundImage: widget.imagePath != null
                    ? NetworkImage(widget.imagePath!)
                    : null,
                backgroundColor: Colors.grey[300],
                child: widget.imagePath == null
                    ? Icon(Icons.person, size: 24.sp)
                    : null,
              ),
              Obx(() {
                final isOnline = controller.isUserOnline(widget.userId ?? '');
                return Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: isOnline ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.w),
                    ),
                  ),
                );
              }),
            ],
          ),
          SizedBox(width: 12.w),
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.name ?? 'Unknown',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Obx(() {
                  final isConnected = controller.isSocketConnected.value;
                  return Row(
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          color: isConnected ? Colors.green : Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        isConnected
                            ? (controller.isUserOnline(widget.userId ?? '')
                                  ? 'Online'
                                  : 'Away')
                            : 'Connecting...',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isConnected ? Colors.green : Colors.orange,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          // Call button
          IconButton(
            onPressed: () {
              Get.toNamed(
                Routes.AUDIO_CALL,
                arguments: {'userId': widget.userId},
              );
            },
            icon: Icon(Icons.call, size: 20.sp),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.onPrimaryColor.withOpacity(0.1),
            ),
          ),
          SizedBox(width: 4.w),
          // // Video call button
          // IconButton(
          //   onPressed: () {
          //     Get.snackbar('Coming Soon', 'Video call feature coming soon');
          //   },
          //   icon: Icon(Icons.videocam, size: 20.sp),
          //   style: IconButton.styleFrom(
          //     backgroundColor: AppColors.onPrimaryColor.withOpacity(0.1),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildDateDivider(DateTime timestamp) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
        SizedBox(width: 8.w),
        Text(
          _formatDate(timestamp),
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: Colors.grey[500]),
        ),
        SizedBox(width: 8.w),
        Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
      ],
    );
  }

  Widget _buildMessageBubble(MessageModel message) {
    final isSentByMe = message.isSentByMe;

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        constraints: BoxConstraints(maxWidth: 280.w),
        child: Column(
          crossAxisAlignment: isSentByMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            // Message container
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSentByMe ? Colors.black : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(isSentByMe ? 16.r : 4.r),
                  bottomRight: Radius.circular(isSentByMe ? 4.r : 16.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Message text
                  Text(
                    message.text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSentByMe ? Colors.white : Colors.black,
                      height: 1.4,
                    ),
                  ),
                  // Image if present
                  if (message.imageUrl != null)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          message.imageUrl!,
                          width: 200.w,
                          height: 150.h,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 200.w,
                              height: 150.h,
                              color: Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 200.w,
                              height: 150.h,
                              color: Colors.grey[300],
                              child: const Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Time and status
            Padding(
              padding: EdgeInsets.only(
                top: 4.h,
                right: isSentByMe ? 4.w : 0,
                left: isSentByMe ? 0 : 4.w,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatTime(message.timestamp),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.grey[500],
                      fontSize: 10.sp,
                    ),
                  ),
                  if (isSentByMe) ...[
                    SizedBox(width: 4.w),
                    _buildMessageStatusIcon(message.status),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageStatusIcon(MessageStatus status) {
    IconData icon;
    Color color;

    switch (status) {
      case MessageStatus.sending:
        icon = Icons.schedule;
        color = Colors.grey[400] ?? Colors.grey;
        break;
      case MessageStatus.sent:
        icon = Icons.check;
        color = Colors.grey[400] ?? Colors.grey;
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        color = Colors.grey[400] ?? Colors.grey;
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = AppColors.onPrimaryColor;
        break;
      case MessageStatus.failed:
        icon = Icons.close;
        color = Colors.red;
        break;
    }

    return Icon(icon, size: 12.sp, color: color);
  }

  Widget _buildTypingIndicator() {
    return SizedBox(
      height: 16.h,
      width: 30.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          3,
          (index) => ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.2).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Interval(
                  index * 0.2,
                  index * 0.2 + 0.6,
                  curve: Curves.easeInOut,
                ),
              ),
            ),
            child: Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Add button
            // GestureDetector(
            //   onTap: () {
            //     Get.snackbar('Info', 'Add media feature coming soon');
            //   },
            //   child: Container(
            //     width: 50.w,
            //     height: 50.w,
            //     decoration: BoxDecoration(
            //       color: Colors.grey.shade400,
            //       shape: BoxShape.circle,
            //     ),
            //     child: Center(
            //       child: Icon(
            //         Icons.add,
            //         color: AppColors.onPrimaryColor,
            //         size: 30.sp,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(width: 12.w),
            // // Input field
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: TextField(
                  controller: controller.messageChatController,
                  onChanged: (value) {
                    controller.setTyping(value.isNotEmpty);
                  },
                  maxLines: null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade400,

                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 13.sp,
                    ),

                    suffixIcon: IconButton(
                      onPressed: _handleSendMessage,
                      icon: const Icon(Icons.send_rounded),
                    ),

                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,

                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                  ),

                  style: TextStyle(fontSize: 13.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _shouldShowDateDivider(MessageModel prev, MessageModel current) {
    return prev.timestamp.day != current.timestamp.day;
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inHours < 24) {
      return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[timestamp.weekday - 1];
    } else {
      return '${timestamp.month}/${timestamp.day}';
    }
  }

  String _formatDate(DateTime timestamp) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    if (timestamp.year == now.year &&
        timestamp.month == now.month &&
        timestamp.day == now.day) {
      return 'Today';
    } else if (timestamp.year == yesterday.year &&
        timestamp.month == yesterday.month &&
        timestamp.day == yesterday.day) {
      return 'Yesterday';
    } else {
      return '${timestamp.month}/${timestamp.day}/${timestamp.year}';
    }
  }
}
