import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sales_officer/Profile/Achievements/Achievements.dart';
import 'package:sales_officer/Profile/Header/Header.dart';
import 'package:sales_officer/Profile/Header/Online.dart';
import 'package:shimmer/shimmer.dart';
import '../Database.dart';
import 'BezierCard/BezierCard.dart';

Stopwatch watch = Stopwatch();
String elapsedTime = '';

class Profile extends StatefulWidget {
  final Function refresh;

  Profile(this.refresh);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double sliderValue = 0;
  bool toggleDataValue = true;

  toggleButton() {
    setState(() {
      toggleDataValue = false;
      toggleValue = !toggleValue;
    });
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        toggleDataValue = true;
      });
    });
  }

  late Timer timer;
  bool startStop = true;


  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
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
    if (toggleValue) {
      startOrStop();
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Header(),
        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Container(
        //     height: 90,
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(60),
        //       color: Colors.grey,
        //     ),
        //   ),
        // ),
        Padding(
          padding:
              const EdgeInsets.only(left: 12.0, bottom: 8, right: 12, top: 12),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: toggleValue
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
                    ? toggleValue
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                  alignment: toggleValue
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
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
        ),
        BezierCard(
          toggleValue,
        ),
        Achievements(),
      ],
    );
  }
}
