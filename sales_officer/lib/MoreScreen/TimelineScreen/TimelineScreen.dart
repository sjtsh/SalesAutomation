import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:sales_officer/Database.dart';
import 'package:timelines/timelines.dart';

import 'DeliveryProcesses.dart';
import 'ActivityWidgets.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  NepaliDateTime? _newdate;

  Future<Null> _selectDatePicker() async {
    NepaliDateTime? _selectedDateTime = await picker.showMaterialDatePicker(
      textDirection: TextDirection.ltr,
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      initialDate: _newdate!,
      firstDate: NepaliDateTime.now().subtract(Duration(days: 30)),
      lastDate: NepaliDateTime.now(),
      currentDate: NepaliDateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (_selectedDateTime != null && _selectedDateTime != _newdate) {
      setState(() {
        _newdate = _selectedDateTime;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _newdate = NepaliDateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
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
                    _newdate!.day.toString(),
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
                        weekday[_newdate!.weekday],
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${month[_newdate!.month]}, ${_newdate!.year.toString()}",
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
            Expanded(
              child: DeliveryProcesses(
                _newdate.toString().substring(0, 10),
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
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
