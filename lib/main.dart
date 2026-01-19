import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'app/core/network/shared_prepharence_helper.dart';
import 'app/core/service/notification-service.dart';
import 'app/core/theme/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

late List<CameraDescription> cameras;
late NotificationService notificationService;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  debugPrint('🔵 BG message: ${message.messageId} data=${message.data}');
  debugPrint('🔵 BG title: ${message.notification?.title}');
  debugPrint('🔵 BG body: ${message.notification?.body}');

  // ✅ Show notification in background too
  try {
    await notificationService.showLocalMessageNotification(
      title: message.notification?.title ??
          message.data['title'] ??
          'New Message',
      body: message.notification?.body ??
          message.data['body'] ??
          'You have a new message',
      payload: message.data.toString(),
    );
  } catch (e) {
    debugPrint('❌ Error showing background notification: $e');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  await SharedPrefHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GoogleSignIn.instance.initialize();

  // ✅ Initialize notification service BEFORE setting background handler
  notificationService = NotificationService();
  await notificationService.initFM();

  // ✅ Register background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.themeData(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    );
  }
}