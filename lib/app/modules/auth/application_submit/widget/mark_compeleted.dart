import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/widget/App_button.dart';
import '../../../../routes/app_pages.dart';

class MarkCompeleted extends StatelessWidget {
  const MarkCompeleted({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);
    return Container(
      child: Column(
        children: [
          Center(
            child: Text(
              "Move Completed",
              style: textStyele.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Text(
              "Your move completed successfully. ",
              style: textStyele.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
