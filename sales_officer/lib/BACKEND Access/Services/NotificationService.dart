import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sales_officer/MoreScreen/ActivitiesScreen/ActivitiesScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/standalone.dart' as tz;

import '../../timer.dart';

FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();

class NotificationService {
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
      RepeatInterval.hourly,
      NotificationDetails(
          android: AndroidNotificationDetails("activity", "activity",
              importance: Importance.max,
              color: Colors.blue,
              visibility: NotificationVisibility.public),
          iOS: IOSNotificationDetails()),
      payload: payload,
    );
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
      if (navigatorKey.currentState != null) {
        navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) {
          return ActivitiesScreen(() {});
        }));
      } else {
        SharedPreferences.getInstance().then(
          (prefs) => prefs.setBool("isNotificationClicked", false),
        );
      }
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
