import 'package:flutter/material.dart';
import 'package:sales_officer/TourPlanScreen/TourDropDowns.dart';

import '../Database.dart';
import '../Header.dart';
import 'TourPlanScreen.dart';

class EditTourPlanScreen extends StatefulWidget {
  final int startDate;
  final int endDate;
  final DateTime now;

  EditTourPlanScreen(this.startDate, this.endDate, this.now);

  @override
  _EditTourPlanScreenState createState() => _EditTourPlanScreenState();
}

class _EditTourPlanScreenState extends State<EditTourPlanScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Column(
          children: [
          Header(7, false),
      Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.black.withOpacity(0.1)))),
        height: 60,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "Start Date:",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "${weeks[widget.now.weekday]}, ${widget
                            .startDate}-${months[widget.now.month - 1]}-${widget
                            .now.year}",
                        style:
                        TextStyle(color: Colors.black.withOpacity(0.5)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "End Date:",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "${weeks[widget.now.weekday]}, ${widget.endDate -
                            dates[widget.now.month - 1]}-${months[widget.now
                            .month]}-${widget.now.year}",
                        style:
                        TextStyle(color: Colors.black.withOpacity(0.5)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      TourDropDowns(widget.startDate, widget.endDate, widget.now),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: MaterialButton(
            color: Colors.green,
            onPressed: () {},
            child: Center(
              child: Text(
                "FILL",
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
    ),);
  }
}
