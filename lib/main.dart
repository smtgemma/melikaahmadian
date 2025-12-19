import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/core/theme/app_theme.dart';
import 'app/routes/app_pages.dart';
late List<CameraDescription> cameras;
Future<void>  main() async{
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return  GetMaterialApp(
          debugShowCheckedModeBanner:false,
          title: 'Flutter Demo',
          theme: AppTheme.themeData(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        ) ;
      },
    );
  }
}

