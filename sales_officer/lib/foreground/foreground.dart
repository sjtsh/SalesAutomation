import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';
import 'package:sales_officer/MoreScreen/ActivitiesScreen/ActivitiesScreen.dart';

import '../timer.dart';

/// foreground process started
///
ReceivePort? receivePort;

Future<void> initForegroundTask() async {
  await FlutterForegroundTask.init(
    androidNotificationOptions: const AndroidNotificationOptions(
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
  await FlutterForegroundTask.saveData(key: 'customData', value: 'hello');

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
        print('receive timestamp: $message');
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
  int time = 0;

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    // You can use the getData function to get the data you saved.
    final customData =
        await FlutterForegroundTask.getData<String>(key: 'customData');
    print('customData: $customData');
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    // time = LogInScreenState.watch.elapsedMillis;
    // print("initial value found to be ${LogInScreenState.watch.elapsedMillis}");
    // int hundreds = (time / 10).truncate();
    // int seconds = (hundreds / 100).truncate();
    // int minutes = (seconds / 60).truncate();
    // int hours = (minutes / 60).truncate();
    //
    // String hoursStr = (hours % 60).toString().padLeft(2, '0');
    // String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    // String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    FlutterForegroundTask.updateService(
      notificationTitle: 'Your LogIn Time',
      notificationText: "hello",
    );
    // Send data to the main isolate.
    sendPort?.send(time);
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    // You can use the clearAllData function to clear all the stored data.
    await FlutterForegroundTask.clearAllData();
  }
}
