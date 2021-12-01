import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:sales_officer/Database.dart';
import 'package:timelines/timelines.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  NepaliDateTime _date = NepaliDateTime.now();

  Future<Null> _selectDatePicker() async {
    NepaliDateTime? _selectedDateTime = await picker.showMaterialDatePicker(
      textDirection: TextDirection.ltr,
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000),
      lastDate: NepaliDateTime(2090),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (_selectedDateTime != null && _selectedDateTime != _date) {
      setState(() {
        _date = _selectedDateTime;
        print(_date.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Container(clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Builder(builder: (context) {
                    return Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 3,
                      offset: Offset(0, 2))
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _date.day.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weekday[_date.weekday],
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${month[_date.month]}, ${_date.year.toString()}",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  // Expanded(
                  //   child: Container(
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12),
                  //         color: Colors.red),
                  //     child: Center(
                  //       child: Text(
                  //         "TODAY",
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Material(
                      color: Color(0xffFDEEEE),
                      clipBehavior: Clip.hardEdge,
                      shape: CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectDatePicker();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _DeliveryProcesses(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InnerTimeline extends StatelessWidget {
  final int index;

  _InnerTimeline(this.index);

  List content = [
    "",
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text("Location . Sukedhara, Kathmandu"),
    ),
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hamro Store",
            style: TextStyle(color: Colors.black),
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order Value"),
                  Text("21254"),
                ],
              ),
              Expanded(child: Container()),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Qty"),
                  Text("154"),
                ],
              ),
              Expanded(child: Container()),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xff9b9b9b),
                        ),),
                      child: Center(
                        child: Text(
                          "View Details",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hamro Store",
            style: TextStyle(color: Colors.black),
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order Value"),
                  Text("21254"),
                ],
              ),
              Expanded(child: Container()),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Qty"),
                  Text("154"),
                ],
              ),
              Expanded(child: Container()),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xff9b9b9b),
                      ),),
                      child: Center(
                        child: Text(
                          "View Details",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text("Location . Sukedhara, Kathmandu"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return index != 0 && index != 5
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 10),
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  content[index],
                ],
              ),
            ),
          )
        : Container(
            height: 50,
          );
  }
}

class _DeliveryProcesses extends StatelessWidget {
  List top_content = [
    ["", ""],
    ["Day Start", "09:30 AM"],
    ["Distributor Order", "11:30 AM"],
    ["Distributor Stock", "12:47 PM"],
    ["Day End", "06:30 PM"],
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: Colors.white,
            nodeItemOverlap: true,
            indicatorPosition: -3,
            indicatorTheme: IndicatorThemeData(
                position: 0, size: 22.0, color: Colors.white),
            connectorTheme: ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: top_content.length + 1,
            contentsBuilder: (_, index) {
              return index != 0 && index != 5
                  ? Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                top_content[index][0],
                                style: DefaultTextStyle.of(context)
                                    .style
                                    .copyWith(
                                        fontSize: 16.0,
                                        color: Colors.black.withOpacity(0.5)),
                              ),
                              Text(
                                "    ⚫    ",
                                style: DefaultTextStyle.of(context)
                                    .style
                                    .copyWith(
                                        fontSize: 6.0,
                                        color: Colors.black.withOpacity(0.5)),
                              ),
                              Text(
                                top_content[index][1],
                                style:
                                    DefaultTextStyle.of(context).style.copyWith(
                                          fontSize: 16.0,
                                        ),
                              ),
                            ],
                          ),
                          _InnerTimeline(index),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  : Container();
            },
            indicatorBuilder: (_, index) {
              if (index == 0 || index == 5) {
                return Container(
                  height: 12,
                );
              }
              // else if (index % 2 == 0) {
              //   return DotIndicator(
              //     color: Colors.red,
              //     child: Icon(
              //       Icons.check,
              //       color: Colors.white,
              //       size: 12.0,
              //     ),
              //   );
              // }
              else {
                return OutlinedDotIndicator(
                  backgroundColor: Colors.red,
                  borderWidth: 5.5,
                );
              }
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
