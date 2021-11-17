import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SOLogInDetailService.dart';
import 'package:sales_officer/Profile/Header/Header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../Database.dart';
import 'Header/Online.dart';

Stopwatch watch = Stopwatch();
String elapsedTime = '';

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
      isRetailing = !isRetailing;
      widget.refreshChart();
    });
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        toggleDataValue = true;
      });
    });
  }

  startOrStop() {
    if (startStop) {
      SOLogInDetailService soLogInDetailService = SOLogInDetailService();
      soLogInDetailService.logIn().then((value) {
        soLogInDetailID = value;
      });
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool("isRetailing", true);
      });
      NepaliDateService nepaliDateService = NepaliDateService();
      nepaliDateService.fetchNepaliDate().then((value) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("logInDateTime", value);
        });
      });
      SharedPreferences.getInstance().then((prefs) {
        prefs.setInt("retailingTime", watch.elapsedMilliseconds);
      });
      startWatch();
    } else {
      SOLogInDetailService soLogInDetailService = SOLogInDetailService();
      soLogInDetailService.updateSOLogInDetail(soLogInDetailID!);
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool("isRetailing", false);
      });
      NepaliDateService nepaliDateService = NepaliDateService();
      nepaliDateService.fetchNepaliDate().then((value) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("logOutDateTime", value);
        });
      });
      SharedPreferences.getInstance().then((prefs) {
        prefs.setInt("retailingTime", watch.elapsedMilliseconds);
      });
      stopWatch();
    }
  }

  startWatch() {
    setState(() {
      startStop = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
        if (watch.isRunning) {
          setState(() {
            elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          });
        }
      });
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

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

  @override
  void initState() {
    // TODO: implement initState
    if (isRetailing) {
      startOrStop();
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, bottom: 8, right: 12, top: 12),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: isRetailing
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
                ? isRetailing
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
                  isRetailing ? Alignment.centerRight : Alignment.centerLeft,
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
