import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  // static final onNotifications = BehaviorSubject<String?>();
  static Future getDetails() async => NotificationDetails(
      android: AndroidNotificationDetails("channel id", "channel name",
          channelDescription: "channel description",
          importance: Importance.max),
      iOS: IOSNotificationDetails());
  static Future showNotification(
      int id, String title, String body, String payload) async {
    return _notifications.show(
        id,
        title,
        body,
        await getDetails(),
        payload: payload);
  }
  // static Future showNotification(
  //     int id, String title, String body, String payload) {
  //   return _notifications.zonedSchedule(
  //       id,
  //       title,
  //       body,
  //       tz.TZDateTime.from(scheduledDate, lz.local),
  //       await NotificationDetails(
  //           android: AndroidNotificationDetails("channel id", "channel name",
  //               channelDescription: "channel description",
  //               importance: Importance.max),
  //           iOS: IOSNotificationDetails()),
  //       payload: payload);
  // }

  // static Future init({bool initScheduled = false}) async {
  //   await _notifications.initialize(
  //       InitializationSettings(
  //         android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  //         iOS: IOSInitializationSettings(),
  //       ),
  //       onSelectNotification: (payload) async {
  //
  //       });
  // }
}
