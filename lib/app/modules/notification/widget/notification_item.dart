import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/modules/notification/controllers/notification_controller.dart';

class NotificationItemWidget extends StatelessWidget {
  final String notificationId;
  final String title;
  final String subTitle;
  final DateTime timestamp;
  final bool isRead;

  const NotificationItemWidget({
    super.key,
    required this.notificationId,
    required this.title,
    required this.subTitle,
    required this.timestamp,
    required this.isRead,
  });



  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();
    var textStyle = TextTheme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Mark as read when tapped
          controller.markAsRead(notificationId);
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: isRead
                ? AppColors.cardColor
                : AppColors.cardColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isRead
                  ? AppColors.strtoColor
                  : AppColors.secoundaryColor.withOpacity(0.3),
              width: isRead ? 0.5 : 1.5,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Leading Icon with indicator
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.onPrimaryColor,
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: AppColors.secoundaryColor,
                    ),
                  ),
                  if (!isRead)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12.w),

              /// Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textStyle.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isRead
                            ? AppColors.secoundaryColor.withOpacity(0.7)
                            : AppColors.secoundaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subTitle,
                      style: textStyle.bodySmall!.copyWith(
                        color: AppColors.secoundaryColor.withOpacity(0.6),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              /// Time and Actions
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    controller.getTimeAgo(timestamp),
                    style: textStyle.bodySmall!.copyWith(
                      color: AppColors.secoundaryColor.withOpacity(0.5),
                      fontSize: 9.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Delete button
                  GestureDetector(
                    onTap: () {
                      _showDeleteDialog(context, controller, notificationId);
                    },
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: AppColors.secoundaryColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
  void _showDeleteDialog(BuildContext context, NotificationController controller,
      String notificationId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notification'),
        content: const Text('Are you sure you want to delete this notification?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteNotification(notificationId);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

}
