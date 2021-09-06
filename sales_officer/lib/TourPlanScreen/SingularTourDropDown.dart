import 'package:flutter/material.dart';

import '../Database.dart';

class SingularTourDropDown extends StatefulWidget {
  final int startDate;
  final int endDate;
  final DateTime now;
  final int index;

  SingularTourDropDown(this.startDate, this.endDate, this.now, this.index);

  @override
  _SingularTourDropDownState createState() => _SingularTourDropDownState();
}

class _SingularTourDropDownState extends State<SingularTourDropDown> {
  String dropDownValue = "Activity";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
      child: Container(
        height: 50,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${weeks[(widget.now.weekday + widget.index) % 7]}, ${(widget.startDate + widget.index) > dates[widget.now.month - 1] ? (widget.startDate + widget.index) % dates[widget.now.month - 1] : (widget.startDate + widget.index)}-${(widget.startDate + widget.index) > dates[widget.now.month - 1] ? months[widget.now.month] : months[widget.now.month - 1]}-${widget.now.year}",
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 10,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    DropdownButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onChanged: (_value) {
                        setState(() {
                          dropDownValue = _value as String;
                        });
                      },
                      underline: Container(),
                      value: dropDownValue,
                      items: <String>[
                        "Activity",
                        "Retailing",
                        "Leave",
                        "Holiday",
                        "Weekly Off",
                        "Depot Visit",
                        "Distributor Search",
                        "Other Activities",
                        "Meeting",
                        "Training"
                      ]
                          .map((e) => DropdownMenuItem<String>(
                                child: Text(
                                  e,
                                  style: TextStyle(fontSize: 14),
                                ),
                                value: e,
                              ))
                          .toList(),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Container(
                        color: Color(0xffF5F5F5),
                        height: 30,
                        child: Center(
                            child: Text(
                          "Details - Beat/Schedule/Comments",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black.withOpacity(0.5)),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
