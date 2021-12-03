import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BACKEND Access/Services/NotificationService.dart';

SharedPreferences? timerPrefs;
String elapsedTime = '';
final ReceivePort port = ReceivePort();
bool isNotificationClicked = false;

final GlobalKey<NavigatorState> navigatorKey =
new GlobalKey<NavigatorState>();

transformMilliSeconds(int milliseconds) {
  int hundreds = (milliseconds / 10).truncate();
  int seconds = (hundreds / 100).truncate();
  int minutes = (seconds / 60).truncate();
  int hours = (minutes / 60).truncate();

  String hoursStr = (hours % 60).toString().padLeft(2, '0');
  String minutesStr = (minutes % 60).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  return "${hoursStr}h:${minutesStr}m:${secondsStr}s";
}

fireAlarm() {
  NotificationService().showNotificationEveryTwoHours(
      0,
      "Update Activity",
      "Click the message to update what your recent activity will be.",
      "");
}

// runAlarm() {
//  // AndroidAlarmManager.oneShot(Duration(seconds: 0), 1, fireAlarm);
// }

// listenForNotification(refresh) {
//   NotificationService.onNotifications.stream.listen((String? payload) {
//     // runApp(MaterialApp(navigatorKey: navigatorKey,));
//     navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) {
//       // isNotificationClicked = true;
//       return ActivitiesScreen(refresh);
//     }));
//   });
// }
