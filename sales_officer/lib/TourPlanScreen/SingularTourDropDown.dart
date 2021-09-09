import 'package:flutter/material.dart';

import '../Database.dart';

class SingularTourDropDown extends StatefulWidget {
  final int startDate;
  final int endDate;
  final DateTime now;
  final int index;
  final Function setIsModalTrue;
  final List tourPlanSingular;

  SingularTourDropDown(this.startDate, this.endDate, this.now, this.index,
      this.setIsModalTrue, this.tourPlanSingular);

  @override
  _SingularTourDropDownState createState() => _SingularTourDropDownState();
}

class _SingularTourDropDownState extends State<SingularTourDropDown> {
  String activityValue = "Choose";
  String detailValue = "Details - Beat/Schedule/Comments";

  setDetail(String detail) {
    setState(() {
      detailValue = detail;
    });
  }

  setActivity(String activity) {
    setState(() {
      activityValue = activity;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.tourPlanSingular[1] == null ? activityValue = "Choose" : activityValue =
    widget.tourPlanSingular[1];
    widget.tourPlanSingular[2] == null ? detailValue = "Details - Beat/Schedule/Comments" : detailValue =
    widget.tourPlanSingular[2];
  }

  @override
  Widget build(BuildContext context) {
    String todayText =
        "${weeks[(widget.now.weekday + widget.index) % 7]}, ${(widget
        .startDate + widget.index) > dates[widget.now.month - 1] ? (widget
        .startDate + widget.index) % dates[widget.now.month - 1] : (widget
        .startDate + widget.index)} - ${(widget.startDate + widget.index) >
        dates[widget.now.month - 1] ? months[widget.now.month] : months[widget
        .now.month - 1]} - ${widget.now.year}";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
      child: Container(
        height: 50,
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
        child: Material(
          child: InkWell(
            onTap: () {
              widget.setIsModalTrue(
                  todayText, setActivity, setDetail, widget.index);
            },
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todayText,
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 10,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 140,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(child: Text(activityValue))),
                              Icon(Icons.keyboard_arrow_down_outlined),
                            ],
                          ),
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
                                  detailValue,
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
        ),
      ),
    );
  }
}
