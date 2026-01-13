import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';

class NotificationItem extends StatelessWidget {
  String ? titel ;
  String ? subTitel ;
  String ? time ;

  NotificationItem({super.key,this.titel,this.subTitel ,this.time});
  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Leading icon
        CircleAvatar(
          backgroundColor: AppColors.onPrimaryColor,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined),
          ),
        ),

        SizedBox(width: 12),

        // Title + Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                titel ?? "Your mover is on the way",
                style: textStyele.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              AutoSizeText(
                subTitel ??
                    "Mike James is on the way to your pickup location",
                style: textStyele.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        SizedBox(width: 8),

        // Time
        Text(
          time ?? "2h",
          style: textStyele.bodyMedium,
        ),
      ],
    );

  }
}
