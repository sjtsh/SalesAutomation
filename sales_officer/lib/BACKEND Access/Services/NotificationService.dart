import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

FlutterLocalNotificationsPlugin notifications =
FlutterLocalNotificationsPlugin();

class NotificationService {
  // static final onNotifications = BehaviorSubject<String?>();
  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) {
    print("into the first function");
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
