import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:sales_officer/Header.dart';

import 'Calendar.dart';

List<String> months = [
  "Baisakh",
  "Jestha",
  "Asar",
  "Shrawan",
  "Bhadra",
  "Ashwin",
  "Kartik",
  "Mangsir",
  "Poush",
  "Magh",
  "Falgun",
  "Chaitra"
];

class TourPlanScreen extends StatefulWidget {
  @override
  _TourPlanScreenState createState() => _TourPlanScreenState();
}

class _TourPlanScreenState extends State<TourPlanScreen> {
  final DateTime now = NepaliDateTime.now();
  int startDay = 0;
  int endDay = 0;
  bool isStartCondition = true;
  Text text = Text(
    "Select Start Point",
    style: TextStyle(color: Colors.green, fontSize: 20),
  );

  setStartDay1(int index) {
    setState(() {
      startDay = index;
      endDay = 0;
      text = Text(
        "Select End Point",
        style: TextStyle(color: Colors.blue, fontSize: 20),
      );
    });
  }

  setEndDay1(int index) {
    setState(() {
      endDay = index;
      text = Text(
        "Select Start Point",
        style: TextStyle(color: Colors.green, fontSize: 20),
      );
    });
  }

  setStartDay2(int index) {
    setState(() {
      startDay = index;
      endDay = 0;
      text = Text(
        "Select End Point",
        style: TextStyle(color: Colors.blue, fontSize: 20),
      );
    });
  }

  setEndDay2(int index) {
    setState(() {
      endDay = index;
      text = Text(
        "Select Start Point",
        style: TextStyle(color: Colors.green, fontSize: 20),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      setState(() {
                        isStartCondition = false;
                      });
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
                        setStartDay1, setEndDay1, isStartCondition),
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
                          setStartDay2, setEndDay2, isStartCondition)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                if (isStartCondition) {
                  setState(() {
                    isStartCondition = false;
                  });
                } else {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return Container();
                  }));
                }
              },
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isStartCondition ? Colors.green: Colors.blue,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      isStartCondition ? "Next" : "Create Tour Plan",
                      style: TextStyle(color: Colors.white),
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
