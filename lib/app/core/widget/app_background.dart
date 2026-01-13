// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackground extends StatelessWidget {
  Widget? child ;
   AppBackground({super.key,this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 16.h),child:child ,);
  }
}
