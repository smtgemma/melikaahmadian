import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String? data;
  final DateTime timestamp;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    this.data,
    required this.timestamp,
    this.isRead = false,
  });

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'data': data,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }

  /// Create from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      data: json['data'],
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      isRead: json['isRead'] ?? false,
    );
  }
}

class NotificationController extends GetxController {
  final logger = Logger();

  // Observables
  RxBool isSwitched = true.obs;
  RxInt unreadCount = 0.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool isLoading = false.obs;

  // Local storage key
  static const String storageKey = 'app_notifications';
  static const String prefKey = 'notifications_enabled';

  @override
  void onInit() {
    super.onInit();
    _loadNotifications();
    _loadPreferences();
  }

  /// ✅ Load notifications from storage
  Future<void> _loadNotifications() async {
    try {
      isLoading.value = true;

      // Simulate loading from shared preferences or local DB
      // In real app, use SharedPreferences, Hive, or SQLite
      final saved = await _getStoredNotifications();
      notifications.assignAll(saved);
      _updateUnreadCount();

      logger.i("✅ Loaded ${notifications.length} notifications from storage");
    } catch (e) {
      logger.e("❌ Error loading notifications: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Load notification preferences
  Future<void> _loadPreferences() async {
    try {
      // In real app, use SharedPreferences
      // final prefs = await SharedPreferences.getInstance();
      // isSwitched.value = prefs.getBool(prefKey) ?? true;
      isSwitched.value = true;
    } catch (e) {
      logger.e("❌ Error loading preferences: $e");
    }
  }

  /// ✅ Save preferences
  Future<void> switchValue({bool? value}) async {
    try {
      isSwitched.value = value ?? !isSwitched.value;

      // In real app, save to SharedPreferences
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setBool(prefKey, isSwitched.value);

      logger.i("✅ Notification preference saved: ${isSwitched.value}");
    } catch (e) {
      logger.e("❌ Error saving preference: $e");
    }
  }

  /// ✅ Add new notification (called from NotificationService)
  Future<void> addNotification({
    required String title,
    required String body,
    String? data,
  }) async {
    try {
      if (!isSwitched.value) {
        logger.w("⚠️ Notifications are disabled");
        return;
      }

      final newNotification = NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        body: body,
        data: data,
        timestamp: DateTime.now(),
        isRead: false,
      );

      // Add to beginning of list
      notifications.insert(0, newNotification);
      _updateUnreadCount();

      // Save to storage
      await _saveNotifications();

      logger.i("✅ Notification added: $title");
    } catch (e) {
      logger.e("❌ Error adding notification: $e");
    }
  }

  /// ✅ Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      final index = notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        notifications[index].isRead = true;
        notifications.refresh();
        _updateUnreadCount();
        await _saveNotifications();
        logger.i("✅ Notification marked as read");
      }
    } catch (e) {
      logger.e("❌ Error marking notification as read: $e");
    }
  }

  /// ✅ Mark all as read
  Future<void> markAllAsRead() async {
    try {
      for (var notification in notifications) {
        notification.isRead = true;
      }
      notifications.refresh();
      _updateUnreadCount();
      await _saveNotifications();
      logger.i("✅ All notifications marked as read");
    } catch (e) {
      logger.e("❌ Error marking all as read: $e");
    }
  }

  /// ✅ Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      notifications.removeWhere((n) => n.id == notificationId);
      _updateUnreadCount();
      await _saveNotifications();
      logger.i("✅ Notification deleted");
    } catch (e) {
      logger.e("❌ Error deleting notification: $e");
    }
  }

  /// ✅ Clear all notifications
  Future<void> clearAllNotifications() async {
    try {
      notifications.clear();
      _updateUnreadCount();
      await _saveNotifications();
      logger.i("✅ All notifications cleared");
    } catch (e) {
      logger.e("❌ Error clearing notifications: $e");
    }
  }

  /// ✅ Update unread count
  void _updateUnreadCount() {
    unreadCount.value = notifications.where((n) => !n.isRead).length;
    logger.i("📊 Unread count: ${unreadCount.value}");
  }

  /// ✅ Get unread notifications
  List<NotificationModel> getUnreadNotifications() {
    return notifications.where((n) => !n.isRead).toList();
  }

  /// ✅ Get notification details
  NotificationModel? getNotificationById(String id) {
    try {
      return notifications.firstWhere((n) => n.id == id);
    } catch (e) {
      return null;
    }
  }

  /// ✅ Format time ago
  String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return "now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    }
  }

  // ============= STORAGE METHODS (Replace with real storage) =============

  /// ✅ Save notifications to storage
  Future<void> _saveNotifications() async {
    try {
      final jsonList = notifications.map((n) => jsonEncode(n.toJson())).toList();
      // In real app, use SharedPreferences:
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setStringList(storageKey, jsonList);
      logger.i("✅ Notifications saved to storage");
    } catch (e) {
      logger.e("❌ Error saving notifications: $e");
    }
  }

  /// ✅ Get stored notifications
  Future<List<NotificationModel>> _getStoredNotifications() async {
    try {
      // In real app, use SharedPreferences:
      // final prefs = await SharedPreferences.getInstance();
      // final jsonList = prefs.getStringList(storageKey) ?? [];

      // For now, return empty (implement with real storage)
      return [];
    } catch (e) {
      logger.e("❌ Error retrieving notifications: $e");
      return [];
    }
  }
}