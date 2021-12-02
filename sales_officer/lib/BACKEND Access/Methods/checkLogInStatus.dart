import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
import 'package:sales_officer/DidnotEndDay.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';
import 'package:sales_officer/foreground/foreground.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Database.dart';
import '../../timer.dart';
import 'package:flutter/material.dart';

void checkLogInStatus(context) {
  // Navigator.push(context, MaterialPageRoute(builder: (_) {
  //   return DidnotEndDay();
  // }));
  NepaliDateService().fetchNepaliDate().then((date) {
    SharedPreferences.getInstance().then((value) {
      if ((value.getString("logInDateTime") ?? "0000-00-00 00:00:00")
              .substring(0, 10) !=
          date.substring(0, 10)) {
        if (DateTime.parse(
                (value.getString("logInDateTime") ?? "0000-00-00 00:00:00"))
            .isAfter(DateTime.parse((value.getString("logOutDateTime") ??
                "0000-00-00 00:00:00")))) {
          print("the day ended without a logout");
          didnotEndDay = true;
        }
        value.setBool("isRetailing", false);
        isRetailing = false;
        LogInScreenState.watch.milliseconds = 0;
        elapsedTime = transformMilliSeconds(LogInScreenState.watch.elapsedMillis);
      } else {
        soLogInDetailID = value.getInt("soLogInDetailID") ?? 0;
        isRetailing = value.getBool("isRetailing") ?? false;
        if (isRetailing!) {
          LogInScreenState.watch.milliseconds = DateTime.parse(date)
              .difference(
                  DateTime.parse(value.getString("logInDateTime") ?? date))
              .inMilliseconds;
          LogInScreenState.watch.milliseconds =
              LogInScreenState.watch.elapsedMillis + value.getInt("retailingTime") ?? 0;
          elapsedTime = transformMilliSeconds(LogInScreenState.watch.elapsedMillis);
        } else {
          LogInScreenState.watch.milliseconds = value.getInt("retailingTime") ?? 0;
          elapsedTime = transformMilliSeconds(LogInScreenState.watch.elapsedMillis);
        }
      }

      FlutterForegroundTask.isRunningService.then((value) {
        if (value) {
          FlutterForegroundTask.restartService();
        }
      });
    });
  });
}
