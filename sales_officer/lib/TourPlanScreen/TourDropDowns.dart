import 'package:flutter/material.dart';
import 'package:sales_officer/TourPlanScreen/SingularTourDropDown.dart';

import '../Database.dart';

class TourDropDowns extends StatefulWidget {
  final int startDate;
  final int endDate;
  final DateTime now;
  final Function setIsModalTrue;

  TourDropDowns(this.startDate, this.endDate, this.now, this.setIsModalTrue);
  @override
  _TourDropDownsState createState() => _TourDropDownsState();
}

class _TourDropDownsState extends State<TourDropDowns> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
          children: List.generate(widget.endDate - widget.startDate + 1,
                  (index) {
                return SingularTourDropDown(widget.startDate, widget.endDate, widget.now, index, widget.setIsModalTrue);
              })),
    );
  }
}
