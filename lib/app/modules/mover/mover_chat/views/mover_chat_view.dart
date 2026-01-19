import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/modules/mover/mover_chat/controllers/mover_chat_controller.dart';
import 'package:melikaahmadian/app/modules/mover/mover_chat/model/chat_list_model.dart';
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
            // Header
            _buildHeader(context, textStyle),
            SizedBox(height: 24.h),
            // Socket status indicator
            Obx(() {
              final isConnected = controller.isSocketConnected.value;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isConnected
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isConnected ? Colors.green : Colors.orange,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: isConnected ? Colors.green : Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      isConnected
                          ? 'Connected • ${controller.getOnlineUserCount()} online'
                          : 'Connecting...',
                      style: textStyle.labelSmall?.copyWith(
                        color: isConnected ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 16.h),
            // Chat List
            Expanded(
              child: Obx(() {
                final model = controller.chatListModel.value;

                // Loading state
                if (model == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        SizedBox(height: 16.h),
                        Text('Loading chats...', style: textStyle.bodyMedium),
                      ],
                    ),
                  );
                }

                // Empty state
                if (model.data.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 60.sp,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No conversations yet',
                          style: textStyle.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Start chatting with movers!',
                          style: textStyle.bodySmall?.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Chat list
                return RefreshIndicator(
                  onRefresh: controller.refreshChatList,
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: 12.w,
                      right: 12.w,
                      bottom: 16.h,
                    ),
                    itemCount: model.data.length,
                    itemBuilder: (context, index) {
                      final chat = model.data[index];
                      final user = chat.otherParticipant;
                      final conversationId = chat.id ?? '';

                      return _buildChatTile(
                        context,
                        user: user,
                        lastMessage:
                            chat.lastMessage?['text'] ?? 'No messages yet',
                        conversationId: conversationId,
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

  Widget _buildHeader(BuildContext context, TextTheme textStyle) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Text(
            "Messages",
            style: textStyle.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "Chat with available movers",
            style: textStyle.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(
    BuildContext context, {
    required OtherParticipant? user,
    required String lastMessage,
    required String conversationId,
  }) {
    final isMoverOnline = controller.isUserOnline(user?.id ?? '');

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.to(
              () => MessageChatView(
                userId: user?.id,
                imagePath: user?.image,
                name: user?.fullName,
                conversationId: conversationId,
              ),
              transition: Transition.rightToLeft,
            );
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Avatar with online indicator
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28.r,
                      backgroundImage: user?.image != null
                          ? NetworkImage(user!.image!)
                          : null,
                      backgroundColor: Colors.grey[300],
                      child: user?.image == null
                          ? Icon(
                              Icons.person,
                              size: 28.sp,
                              color: Colors.grey[600],
                            )
                          : null,
                    ),
                    // Online indicator
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14.w,
                        height: 14.w,
                        decoration: BoxDecoration(
                          color: isMoverOnline ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.w),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
                // Chat info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              user?.fullName ?? "Unknown",
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Status indicator
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: _getRoleColor(user?.role).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              user?.role ?? "USER",
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: _getRoleColor(user?.role),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 9.sp,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      // Last message
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              lastMessage,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.grey[600],
                                    height: 1.3,
                                  ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      // Email
                      Text(
                        user?.email ?? "",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey[500],
                          fontSize: 9.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // Online status
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: isMoverOnline
                            ? Colors.green.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        isMoverOnline ? 'Online' : 'Away',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isMoverOnline ? Colors.green : Colors.grey,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getRoleColor(String? role) {
    switch (role?.toUpperCase()) {
      case 'PROVIDER':
        return Colors.blue;
      case 'ADMIN':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
