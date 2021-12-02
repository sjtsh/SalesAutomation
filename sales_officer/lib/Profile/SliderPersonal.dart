import 'dart:async';
import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter/material.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NotificationService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SOLogInDetailService.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';
import 'package:sales_officer/MoreScreen/ActivitiesScreen/ActivitiesScreen.dart';
import 'package:sales_officer/Profile/Header/Header.dart';
import 'package:sales_officer/foreground/foreground.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../Database.dart';
import '../timer.dart';
import 'Header/Online.dart';


class SliderPersonal extends StatefulWidget {
  final Function refreshChart;

  SliderPersonal(this.refreshChart);

  @override
  State<SliderPersonal> createState() => _SliderPersonalState();
}

class _SliderPersonalState extends State<SliderPersonal> {
  bool toggleDataValue = true;
  var timer;
  bool startStop = true;

  toggleButton() {
    setState(() {
      toggleDataValue = false;
      isRetailing = !isRetailing!;
      widget.refreshChart();
    });
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        toggleDataValue = true;
      });
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _initForegroundTask();
  // }
  //
  // @override
  // void dispose() {
  //   _receivePort?.close();
  //   super.dispose();
  // }
  /// for ground task ..............................
  ///
  ///

  startOrStop() async {
    if (startStop) {
      SOLogInDetailService soLogInDetailService = SOLogInDetailService();
      soLogInDetailService.logIn().then((id) {
        soLogInDetailID = id;
        NepaliDateService nepaliDateService = NepaliDateService();
        nepaliDateService.fetchNepaliDate().then((value) {
          SharedPreferences.getInstance().then((prefs) {
            timerPrefs = prefs;
            prefs.setBool("isRetailing", true);
            prefs.setString("logInDateTime", value);
            prefs.setInt("retailingTime", LogInScreenState.watch.elapsedMillis);
            prefs.setInt("soLogInDetailID", id);
          });
        });
      });
      startWatch();
      initForegroundTask().then((value) {
        FlutterForegroundTask.isRunningService.then((value) {
          stopForegroundTask();
          startForegroundTask();
        });
      });
      fireAlarm();
    } else {
      stopWatch();
      SOLogInDetailService soLogInDetailService = SOLogInDetailService();
      soLogInDetailService.updateSOLogInDetail(soLogInDetailID!);
      NepaliDateService nepaliDateService = NepaliDateService();
      nepaliDateService.fetchNepaliDate().then((value) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setBool("isRetailing", false);
          prefs.setString("logOutDateTime", value);
          prefs.setInt("retailingTime", LogInScreenState.watch.elapsedMillis);
        });
      });
      NotificationService().cancelAllNotifications();
      stopForegroundTask();
    }
  }

  startWatch() {
    setState(() {
      startStop = false;
      LogInScreenState.watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
        if (LogInScreenState.watch.isRunning && mounted) {
          setState(() {
            elapsedTime = transformMilliSeconds(LogInScreenState.watch.elapsedMillis);
          });
        }
      });
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      LogInScreenState.watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = LogInScreenState.watch.elapsedMillis;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (isRetailing!) {
      startWatch();
    }
    super.initState();
  }

  @override
  void dispose() {
    receivePort?.close();

    // TODO: implement dispose
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, bottom: 6, right: 12, top: 12),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: isRetailing!
              ? LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color(0xff34E77E),
                    Color(0xff129C8D),
                  ],
                )
              : LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color(0xffEB1469),
                    Color(0xffFD5B11),
                  ],
                ),
          // color: toggleValue
          //     ? Colors.green.withOpacity(0.1)
          //     : Colors.red.withOpacity(0.1),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            toggleDataValue
                ? isRetailing!
                    ? Positioned(
                        left: 30,
                        right: 0,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "STATUS",
                                  style: TextStyle(
                                    fontFamily: "lato",
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Retailing",
                                  style: TextStyle(
                                      fontFamily: "lato",
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              width: 1,
                              height: 60,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TOTAL TIME",
                                  style: TextStyle(
                                    fontFamily: "lato",
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  elapsedTime,
                                  style: TextStyle(
                                      fontFamily: "lato",
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            SizedBox(
                              height: 58,
                              width: 58,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      )
                    : Positioned(
                        left: 0,
                        right: 30,
                        child: Shimmer.fromColors(
                          highlightColor: Colors.grey,
                          baseColor: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                height: 58,
                                width: 58,
                              ),
                              Expanded(child: Container()),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
                              Expanded(child: Container()),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "STATUS",
                                    style: TextStyle(
                                      fontFamily: "lato",
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Not Retailing",
                                    style: TextStyle(
                                        fontFamily: "lato",
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              elapsedTime != ""
                                  ? Expanded(child: Container())
                                  : Container(),
                              elapsedTime != ""
                                  ? Container(
                                      margin: EdgeInsets.all(10),
                                      width: 1,
                                      height: 60,
                                      color: Colors.white,
                                    )
                                  : Container(),
                              elapsedTime != ""
                                  ? Expanded(child: Container())
                                  : Container(),
                              elapsedTime != ""
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "TOTAL TIME",
                                          style: TextStyle(
                                            fontFamily: "lato",
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Builder(builder: (context) {
                                          return Text(
                                            elapsedTime,
                                            style: TextStyle(
                                                fontFamily: "lato",
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      )
                : Container(),
            AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              alignment:
                  isRetailing! ? Alignment.centerRight : Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return Header();
                      });
                },
                onHorizontalDragEnd: (a) {
                  toggleButton();
                  startOrStop();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Online(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StopWatchPersonal extends Stopwatch {
  int _starterMilliseconds = 0;

  StopWatchPersonal();

  get elapsedDuration {
    return Duration(
        microseconds:
            this.elapsedMicroseconds + (this._starterMilliseconds * 1000));
  }

  get elapsedMillis {
    return this.elapsedMilliseconds + this._starterMilliseconds;
  }

  set milliseconds(int timeInMilliseconds) {
    this._starterMilliseconds = timeInMilliseconds;
  }

  getMyTime() {
    return this.elapsedMilliseconds + _starterMilliseconds;
  }
}
