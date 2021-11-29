import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
import 'package:sales_officer/DidnotEndDay.dart';
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
        watch.milliseconds = 0;
        elapsedTime = transformMilliSeconds(watch.elapsedMillis);
      } else {
        soLogInDetailID = value.getInt("soLogInDetailID") ?? 0;
        isRetailing = value.getBool("isRetailing") ?? false;
        if (isRetailing!) {
          watch.milliseconds = DateTime.parse(date)
              .difference(
                  DateTime.parse(value.getString("logInDateTime") ?? date))
              .inMilliseconds;
          watch.milliseconds =
              watch.elapsedMillis + value.getInt("retailingTime") ?? 0;
          elapsedTime = transformMilliSeconds(watch.elapsedMillis);
        } else {
          watch.milliseconds = value.getInt("retailingTime") ?? 0;
          elapsedTime = transformMilliSeconds(watch.elapsedMillis);
        }
      }
    });
  });
}
