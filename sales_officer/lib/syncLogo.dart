import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:sales_officer/BACKEND%20Access/Services/LastUpdatedService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BACKEND Access/Methods/loadLocalData.dart';
import 'Notification/NotificationScreen.dart';

class SyncIcon extends StatefulWidget {
  final Function refresh;
  final bool isNotBackIcon;

  SyncIcon(this.refresh, this.isNotBackIcon);

  @override
  State<SyncIcon> createState() => _SyncIconState();
}

class _SyncIconState extends State<SyncIcon> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );
  String lastUpdated = "0000-00-00 00:00:00";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LastUpdatedService lastUpdatedService = LastUpdatedService();
    lastUpdatedService.fetchLastUpdateds().then((value) {
      setState(() {
        lastUpdated = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          loadLocalData(widget.refresh);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          NepaliDateService nepaliDateService = NepaliDateService();
          nepaliDateService.fetchNepaliDate().then((value) {
            prefs.setString("lastUpdated", value);
            setState(() {});
          });
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: widget.isNotBackIcon
              ? Stack(
                  children: [
                    Center(
                      child: !condition
                          ? RotationTransition(
                              turns: _animation,
                              child: Icon(
                                Icons.sync,
                                color: Colors.green,
                              ),
                            )
                          : Icon(
                              Icons.sync,
                              color: Colors.black,
                            ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  ],
                )
              // child: widget.isNotBackIcon
              //     ? FutureBuilder(
              //         future: SharedPreferences.getInstance(),
              //         builder: (context, AsyncSnapshot snapshot) {
              //           bool isToBeUpdated = false;
              //           if (snapshot.hasData) {
              //             SharedPreferences prefs = snapshot.data;
              //             String date = prefs.getString('lastUpdated') ??
              //                 "0000-00-00 00:00:00";
              //             bool isToBeUpdated =
              //                 findIfNeedToUpdate(lastUpdated, date);
              //             return Stack(
              //               children: [
              //                 Center(
              //                   child: !condition
              //                       ? RotationTransition(
              //                           turns: _animation,
              //                           child: Icon(
              //                             Icons.sync,
              //                             color: Colors.green,
              //                           ),
              //                         )
              //                       : Icon(
              //                           Icons.sync,
              //                           color: Colors.black,
              //                         ),
              //                 ),
              //                 Container(
              //                   height: 10,
              //                   width: 10,
              //                   decoration: BoxDecoration(
              //                     color: isToBeUpdated
              //                         ? Colors.green
              //                         : Colors.transparent,
              //                     shape: BoxShape.circle,
              //                   ),
              //                 )
              //               ],
              //             );
              //           }
              //           return Stack(
              //             children: [
              //               Center(
              //                 child: !condition
              //                     ? RotationTransition(
              //                         turns: _animation,
              //                         child: Icon(
              //                           Icons.sync,
              //                           color: Colors.green,
              //                         ),
              //                       )
              //                     : Icon(
              //                         Icons.sync,
              //                         color: Colors.black,
              //                       ),
              //               ),
              //               Container(
              //                 height: 10,
              //                 width: 10,
              //                 decoration: BoxDecoration(
              //                   color: isToBeUpdated
              //                       ? Colors.green
              //                       : Colors.transparent,
              //                   shape: BoxShape.circle,
              //                 ),
              //               )
              //             ],
              //           );
              //         })
              : Container(),
        ),
      ),
    );
  }
}

bool findIfNeedToUpdate(String lastUpdated, String date) {
  bool isToBeUpdated = false;
  int year = int.parse(date.substring(0, 4));
  int month = int.parse(date.substring(5, 7));
  int day = int.parse(date.substring(8, 10));
  int hour = int.parse(date.substring(11, 13));
  int min = int.parse(date.substring(14, 16));
  int sec = int.parse(date.substring(17, 19));
  int updatedYear = int.parse(lastUpdated.substring(0, 4));
  int updatedMonth = int.parse(lastUpdated.substring(5, 7));
  int updatedDay = int.parse(lastUpdated.substring(8, 10));
  int updatedHour = int.parse(lastUpdated.substring(11, 13));
  int updatedMin = int.parse(lastUpdated.substring(14, 16));
  int updatedSec = int.parse(lastUpdated.substring(17, 19));
  if (updatedYear > year) {
    isToBeUpdated = true;
  } else if (updatedYear == year) {
    if (updatedMonth > month) {
      isToBeUpdated = true;
    } else if (updatedMonth == month) {
      if (updatedDay > day) {
        isToBeUpdated = true;
      } else if (updatedDay == day) {
        if (updatedHour > hour) {
          isToBeUpdated = true;
        } else if (updatedHour == hour) {
          if (updatedMin > min) {
            isToBeUpdated = true;
          } else if (updatedMin == min) {
            if (updatedSec > sec) {
              isToBeUpdated = true;
            } else {
              isToBeUpdated = false;
            }
          } else {
            isToBeUpdated = false;
          }
        } else {
          isToBeUpdated = false;
        }
      } else {
        isToBeUpdated = false;
      }
    } else {
      isToBeUpdated = false;
    }
  } else {
    isToBeUpdated = false;
  }
  return isToBeUpdated;
}
