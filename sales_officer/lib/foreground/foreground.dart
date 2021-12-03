import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';
import 'package:sales_officer/MoreScreen/ActivitiesScreen/ActivitiesScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../timer.dart';

/// foreground process started
///
ReceivePort? receivePort;

Future<void> initForegroundTask() async {
  await FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'notification_channel_id',
      channelName: 'Foreground Notification',
      channelDescription:
          'This notification appears when the foreground service is running.',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
      iconData: NotificationIconData(
        resType: ResourceType.mipmap,
        resPrefix: ResourcePrefix.ic,
        name: 'launcher',
      ),
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: true,
      playSound: false,
    ),
    foregroundTaskOptions: const ForegroundTaskOptions(
      interval: 1000,
      autoRunOnBoot: true,
      allowWifiLock: true,
    ),
    printDevLog: true,
  );
}

Future<bool> startForegroundTask() async {
  await SharedPreferences.getInstance().then(
      (e) => e.setInt("customData", LogInScreenState.watch.elapsedMillis));
  if (await FlutterForegroundTask.isRunningService) {
    receivePort = await FlutterForegroundTask.restartService();
  } else {
    receivePort = await FlutterForegroundTask.startService(
      notificationTitle: 'Retailing Started',
      notificationText: 'Tap to return to the app',
      callback: startCallback,
    );
  }

  if (receivePort != null) {
    receivePort = receivePort;
    receivePort?.listen((message) {
      if (message is DateTime) {
        // print('receive timestamp: $message');
      } else if (message is int) {
        print('receive updateCount: $message');
      }
    });

    return true;
  }

  return false;
}

Future<bool> stopForegroundTask() async {
  return await FlutterForegroundTask.stopService();
}

void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(FirstTaskHandler());
}

class FirstTaskHandler implements TaskHandler {

  int? time;
  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    // You can use the getData function to get the data you saved.
    int? customData =
        await SharedPreferences.getInstance().then(
                (e) => e.getInt("customData"));
    print('customData: $customData');
    time = customData;
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    print("initial value found to be ${time}");
    int hundreds = (time! / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    FlutterForegroundTask.updateService(
      notificationTitle: 'Your LogIn Time',
      notificationText: "${hoursStr}h:${minutesStr}m:${secondsStr}s",
    );
    // Send data to the main isolate.
    time = time! + 1000;
    sendPort?.send(time);
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    // You can use the clearAllData function to clear all the stored data.
    // await FlutterForegroundTask.clearAllData();
  }

  @override
  void onButtonPressed(String id) {
    // TODO: implement onButtonPressed
    print("should diverge");
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) {
      // isNotificationClicked = true;
      return ActivitiesScreen(() {});
    }));
  }
}
