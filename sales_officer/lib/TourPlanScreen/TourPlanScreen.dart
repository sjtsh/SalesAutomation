import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:sales_officer/Header.dart';

import '../Database.dart';
import 'Calendar.dart';
import 'EditTourPlanScreen.dart';

class TourPlanScreen extends StatefulWidget {
  @override
  _TourPlanScreenState createState() => _TourPlanScreenState();
}

class _TourPlanScreenState extends State<TourPlanScreen> {
  final DateTime now = NepaliDateTime.now();
  int startDay = 0;
  int endDay = 0;
  bool isStartCondition = true;
  bool isButton1Disabled = true;
  bool isButton2Disabled = true;

  setStartDay(int index) {
    setState(() {
      startDay = index;
      endDay = 0;
      isButton1Disabled = false;
    });
  }

  setEndDay(int index) {
    setState(() {
      endDay = index;
      isButton2Disabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Column(
        children: [
          Header(7, false),
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isStartCondition = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  color: Colors.black.withOpacity(0.1)),
                              bottom: BorderSide(
                                  color: isStartCondition
                                      ? Colors.green
                                      : Colors.black.withOpacity(0.1),
                                  width: 3))),
                      child: Center(
                          child: Text(
                        "Start Day",
                        style: TextStyle(
                            color: isStartCondition
                                ? Colors.green
                                : Colors.black.withOpacity(0.1)),
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (!isButton1Disabled) {
                        setState(() {
                          isStartCondition = false;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  color: Colors.black.withOpacity(0.1)),
                              bottom: BorderSide(
                                  color: !isStartCondition
                                      ? Colors.blue
                                      : Colors.black.withOpacity(0.1),
                                  width: 3))),
                      child: Center(
                          child: Text(
                        "End Day",
                        style: TextStyle(
                            color: !isStartCondition
                                ? Colors.blue
                                : Colors.black.withOpacity(0.1)),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
          isStartCondition
              ? Expanded(
                  child: Container(
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            offset: Offset(0, 2))
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "${months[now.month - 1]} ${now.year}",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Calendar(now.month, startDay, endDay,
                              setStartDay, setEndDay, isStartCondition),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            offset: Offset(0, 2))
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "${months[now.month]} ${now.year}",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            child: Calendar(now.month + 1, startDay, endDay,
                                setStartDay, setEndDay, isStartCondition)),
                      ],
                    ),
                  ),
                ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Container(
              clipBehavior: Clip.hardEdge,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: MaterialButton(
                color: isStartCondition && !isButton1Disabled
                    ? Colors.green
                    : !isStartCondition && !isButton2Disabled
                        ? Colors.blue
                        : Colors.blueGrey,
                onPressed: () {
                  if (isStartCondition) {
                    if (!isButton1Disabled) {
                      setState(() {
                        isStartCondition = false;
                      });
                    }
                  } else {
                    if (!isButton2Disabled) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return EditTourPlanScreen(startDay, endDay, now);
                      }));
                    }
                  }
                },
                child: Center(
                  child: Text(
                    isStartCondition ? "Next" : "Create Tour Plan",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
