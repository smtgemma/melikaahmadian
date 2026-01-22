import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import '../../../core/const/app_colors.dart';
import '../controllers/notification_controller.dart';
import '../widget/notification_item.dart';

class NotificationViewUpdated extends GetView<NotificationController> {
  const NotificationViewUpdated({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextTheme.of(context);

    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            SizedBox(height: 24.h),

            /// Header with Mark All as Read
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notifications",
                      style: textStyle.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => Text(
                        "You have ${controller.unreadCount.value} unread",
                        style: textStyle.bodyMedium,
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  if (controller.unreadCount.value == 0) {
                    return const SizedBox.shrink();
                  }
                  return TextButton.icon(
                    onPressed: () {
                      controller.markAllAsRead();
                    },
                    icon: const Icon(Icons.done_all),
                    label: const Text('Mark All Read'),
                  );
                }),
              ],
            ),
            SizedBox(height: 16.h),

            /// Notifications List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secoundaryColor,
                    ),
                  );
                }

                if (controller.notifications.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_off_outlined,
                          size: 48,
                          color: AppColors.secoundaryColor.withOpacity(0.3),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "No Notifications",
                          style: textStyle.titleMedium!.copyWith(
                            color: AppColors.secoundaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  // padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = controller.notifications[index];
                    return NotificationItemWidget(
                      notificationId: notification.id,
                      title: notification.title,
                      subTitle: notification.body,
                      timestamp: notification.timestamp,
                      isRead: notification.isRead,
                    );
                  },
                );
              }),
            ),

            /// Clear All Button
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Obx(() {
                if (controller.notifications.isEmpty) {
                  return const SizedBox.shrink();
                }
                return SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      _showClearAllDialog(context, controller);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      backgroundColor: AppColors.secoundaryColor.withOpacity(
                        0.1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Clear All Notifications',
                      style: textStyle.bodyMedium!.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearAllDialog(
    BuildContext context,
    NotificationController controller,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text(
          'Are you sure you want to delete all notifications?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.clearAllNotifications();
              Navigator.pop(context);
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
