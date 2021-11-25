import 'dart:async';
import 'dart:isolate';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'BACKEND Access/Services/NotificationService.dart';
import 'Profile/SliderPersonal.dart';

SharedPreferences? timerPrefs;
StopWatchPersonal watch = StopWatchPersonal();
String elapsedTime = '';
final ReceivePort port = ReceivePort();

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
  NotificationService().showNotification(
      id: 0, title : "this is a title", body: "this is a body", payload: "this is a payload");
  print("hello");
}
