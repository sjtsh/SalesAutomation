import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Services/LastUpdatedService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_tooltip/super_tooltip.dart';

import 'BACKEND Access/Methods/loadLocalData.dart';

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
  SuperTooltip tooltip = SuperTooltip(
    popupDirection: TooltipDirection.down,
    content: Container(),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void close() {
    tooltip.close();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          tooltip = SuperTooltip(
              arrowTipDistance: 0,
              borderColor: Colors.transparent,
              shadowColor: Colors.black.withOpacity(0.2),
              content: SizedBox(
                height: 80,
                width: 190,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.sync),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            !condition
                                ? Text(
                                    "Loading ... ",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 12,
                                        decoration: TextDecoration.none,fontFamily: "lato"),
                                  )
                                : Text(
                                    "Last Sync Date",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 12,
                                        decoration: TextDecoration.none,fontFamily: "lato"
                                    ),
                                  ),
                            FutureBuilder(
                              future: SharedPreferences.getInstance(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  SharedPreferences prefs = snapshot.data;
                                  return Text(
                                    prefs.getString("lastUpdated") ?? "0000-00-00 00:00:00",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        decoration: TextDecoration.none,fontFamily: "lato"),
                                  );
                                }
                                return Text(
                                  "0000-00-00 00:00:00",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      decoration: TextDecoration.none,fontFamily: "lato"),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 3,
                                offset: Offset(0, 2))
                          ],
                        ),
                        child: !condition
                            ? Container(
                                alignment: Alignment.center,
                                height: 30,
                                color: Color(0xff60D74D),
                                child: Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () async {
                                    loadLocalData(widget.refresh, close);
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    NepaliDateService nepaliDateService =
                                        NepaliDateService();
                                    nepaliDateService
                                        .fetchNepaliDate()
                                        .then((value) {
                                      prefs.setString("lastUpdated", value);
                                      setState(() {});
                                    });
                                    tooltip.close();
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    color: Color(0xff60D74D),
                                    child: Builder(builder: (context) {
                                      return Text(
                                        "SYNC NOW",
                                        style: TextStyle(
                                          color: Colors.white,fontFamily: "lato",
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              popupDirection: TooltipDirection.down);
          tooltip.show(context);
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: widget.isNotBackIcon
              ? FutureBuilder(
                  future: SharedPreferences.getInstance().then((value) =>
                      findIfNeedToUpdate(value.getString('lastUpdated') ??
                          "0000-00-00 00:00:00")),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return Stack(
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
                                color: snapshot.data
                                    ? Colors.green
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        ],
                      );
                    }
                    return Stack(
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
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    );
                  })
              : Container(),
        ),
      ),
    );
  }
}

Future<bool> findIfNeedToUpdate(
  String date,
) async {
  print("in to the function find if need to update");
  LastUpdatedService lastUpdatedService = LastUpdatedService();
  bool isToBeUpdated =
      await lastUpdatedService.fetchLastUpdateds().then((value) {
    String lastUpdated = value;
    bool isToBeUpdated = false;
    print(lastUpdated);
    print(date);
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
    print(isToBeUpdated);
    return isToBeUpdated;
  });
  return isToBeUpdated;
}
