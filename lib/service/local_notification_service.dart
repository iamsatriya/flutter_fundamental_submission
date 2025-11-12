import 'package:flutter/foundation.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

enum NotificationId {
  scheduledLunch(1, 'Scheduled Lunch Notification'),
  workmanagerNotification(2, 'Scheduled Lunch Notification with Workmanager');

  final int id;
  final String name;

  const NotificationId(this.id, this.name);
}

class LocalNotificationService {
  Future<void> init() async {
    const androidInitializationSettings = AndroidInitializationSettings(
      'app_icon',
    );

    const darwinInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// [_isAndroidPermissionGranted] is for android 13 above, check is already granted
  Future<bool> _isAndroidPermissionGranted() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.areNotificationsEnabled() ??
        false;
  }

  /// [_requestAndroidNotificationsPermission] is for android 13 above, requesting notification permission
  Future<bool> _requestAndroidNotificationsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission() ??
        false;
  }

  Future<bool?> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iOSImplementation = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      return await iOSImplementation?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final notificationEnabled = await _isAndroidPermissionGranted();
      final requestAlarmEnabled = await _requestExactAlarmsPermission();
      if (!notificationEnabled) {
        final requestNotificationsPermission =
            await _requestAndroidNotificationsPermission();
        return requestNotificationsPermission && requestAlarmEnabled;
      }
      return notificationEnabled && requestAlarmEnabled;
    } else {
      return false;
    }
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final TimezoneInfo timezoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
  }

  tz.TZDateTime _nextInstanceOfElevenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      11,
      00,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> scheduleDailyElevenAmNotification({
    String channelId = "Scheduled Notification Id",
    String channelName = "Scheduled Notification Name",
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final scheduledDate = _nextInstanceOfElevenAM();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      NotificationId.scheduledLunch.id,
      'It\'s time for lunch!',
      'Let\'s find the best restaurant here!',
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelScheduledNotification() async {
    final pendingNotificationRequests = await flutterLocalNotificationsPlugin
        .pendingNotificationRequests();

    if (pendingNotificationRequests.isNotEmpty) {
      await flutterLocalNotificationsPlugin.cancel(
        NotificationId.scheduledLunch.id,
      );
    }
  }

  Future<bool> _requestExactAlarmsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestExactAlarmsPermission() ??
        false;
  }

  Future<void> showWorkManagerNotification({
    required String body,
    String channelId = "Workmanager Notification",
    String channelName = "Workmanager Notifications",
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      NotificationId.workmanagerNotification.id,
      'It\'s time for lunch!',
      'Have you try $body? it\'s looks tastefull',
      notificationDetails,
    );
  }
}
