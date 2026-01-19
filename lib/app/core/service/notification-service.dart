import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class NotificationService {
  final logger = Logger();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String channelId = 'high_importance_channel';
  static const String channelName = 'High Importance Notifications';

  Future<void> initFM() async {
    // ✅ Android initialization with EXACT channel ID
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // ✅ iOS initialization
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        logger.i("🔔 Notification tapped: ${details.payload}");
      },
    );

    // ✅ Create Android notification channel
    await _createAndroidNotificationChannel();

    // ✅ Request Android runtime permissions
    await _requestAndroidPermissions();

    // ✅ Request iOS permissions
    await _requestIOSPermissions();

    // ✅ Set foreground notification options
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // ✅ Get and save token
    await _getAndSaveToken();

    // ✅ Listen to foreground messages
    _listenToForegroundMessages();
  }

  /// Create Android notification channel (REQUIRED for Android 8+)
  /// Create Android notification channel (REQUIRED for Android 8+)
  Future<void> _createAndroidNotificationChannel() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    if (androidImplementation != null) {
      await androidImplementation.createNotificationChannel(
        AndroidNotificationChannel(
          channelId, // First positional parameter: id
          channelName, // Second positional parameter: name
          description: 'Important notifications',
          importance: Importance.max,
          enableLights: true,
          enableVibration: true,
          playSound: true,
          showBadge: true,
        ),
      );
      logger.i("✅ Android notification channel created");
    }
  }

  /// Request Android runtime permissions (Android 13+)
  Future<void> _requestAndroidPermissions() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      if (androidImplementation != null) {
        final bool? granted = await androidImplementation
            .requestNotificationsPermission();
        if (granted ?? false) {
          logger.i("✅ Android notification permission granted");
        } else {
          logger.w("⚠️ Android notification permission denied");
        }
      }
    }
  }

  /// Request iOS permission for notifications
  Future<void> _requestIOSPermissions() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      switch (settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
          logger.i("✅ iOS Notification permission granted.");
          break;
        case AuthorizationStatus.provisional:
          logger.w("⚠️ iOS provisional permission granted.");
          break;
        case AuthorizationStatus.denied:
          logger.e("❌ iOS Notification permission denied.");
          break;
        default:
          logger.w(
            "❓ iOS Notification permission status: ${settings.authorizationStatus}",
          );
      }
    }
  }

  /// Get and save the FCM token
  Future<void> _getAndSaveToken() async {
    try {
      late String? tokens;
      if (Platform.isIOS || Platform.isMacOS) {
        tokens = await _messaging.getAPNSToken();
        if (tokens == null) {
          logger.w(
            "⚠️ APNS token not available yet. (This is NORMAL on Simulator)",
          );
          return;
        } else {
          logger.i("📨 APNS token received: $tokens");
        }
      } else {
        tokens = await _messaging.getToken();
        if (tokens != null) {
          logger.i("📱 FCM Token saved: $tokens");
        } else {
          logger.w("⚠️ FCM token is null. Check APNs setup or network.");
        }
      }

      // Token refresh listener
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
        logger.i("🔁 FCM Token refreshed: $newToken");
      });
    } catch (e) {
      logger.e("❌ Error getting FCM token: $e");
    }
  }

  /// Listen to foreground messages
  void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.i("📩 Foreground message received");
      logger.i("Title: ${message.notification?.title}");
      logger.i("Body: ${message.notification?.body}");
      logger.i("Data: ${message.data}");

      final title =
          message.notification?.title ?? message.data['title'] ?? 'New Message';
      final body =
          message.notification?.body ??
          message.data['body'] ??
          'You have a new message';

      if (body.isNotEmpty) {
        showLocalMessageNotification(
          title: title,
          body: body,
          payload: message.data.toString(),
        );
      }
    });
  }

  /// Notification UI details for Android & iOS
  NotificationDetails _notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: 'Important notifications',
        importance: Importance.max,
        priority: Priority.high,
        enableLights: true,
        enableVibration: true,
        playSound: true,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  /// Show foreground notification manually
  Future<void> showLocalMessageNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      await flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title,
        body,
        _notificationDetails(),
        payload: payload ?? '',
      );
      logger.i("✅ Notification displayed: $title");
    } catch (e) {
      logger.e("❌ Error showing notification: $e");
    }
  }

  /// Cancel all local notifications
  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
