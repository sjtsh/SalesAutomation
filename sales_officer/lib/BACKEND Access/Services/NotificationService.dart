import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/standalone.dart' as tz;

FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();

class NotificationService {

  static final onNotifications = BehaviorSubject<String?>();

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) {
    return notifications.show(
        id,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails("activity", "activity",
                importance: Importance.max,
                color: Colors.blue,
                visibility: NotificationVisibility.public),
            iOS: IOSNotificationDetails()),
        payload: payload);
  }

  Future showNotificationEveryTwoHours(
      int id, String title, String body, String payload) {
    return notifications.periodicallyShow(
        id,
        title,
        body,
        RepeatInterval.everyMinute,
        NotificationDetails(
            android: AndroidNotificationDetails("activity", "activity",
                importance: Importance.max,
                color: Colors.blue,
                visibility: NotificationVisibility.public),
            iOS: IOSNotificationDetails()));
  }

  static Future initializeNotification() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('logo'),
            iOS: IOSInitializationSettings(),
            macOS: MacOSInitializationSettings());
    // await notifications.initialize(initializationSettings,
    //     onSelectNotification: (String? payload)=> print("selected a notification $payload"));
    await notifications.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      onNotifications.add(payload);
    });
  }

  cancelAllNotifications() {
    notifications.cancelAll();
  }

// Future showNotification(int id, String title, String body,
//     String payload) {
//   return _notifications.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(scheduledDate, lz.local),
//       await NotificationDetails(
//       android: AndroidNotificationDetails("channel id", "channel name",
//       channelDescription: "channel description",
//       importance: Importance.max),
//   iOS: IOSNotificationDetails()),
//   payload: payload);
// }
}
