import 'package:flutter/material.dart';
import 'package:sales_officer/TourPlanScreen/ModalSheet/ActivityList.dart';

import 'SelectedList.dart';

class ModalSheetTourPlan extends StatefulWidget {
  final String todayText;
  final Function setActivity;
  final Function setDetail;
  final int index;
  final Function setIsModalFalse;
  final Function setTourPlan;

  ModalSheetTourPlan(this.todayText, this.setActivity, this.setDetail, this.index, this.setIsModalFalse, this.setTourPlan);

  @override
  _ModalSheetTourPlanState createState() => _ModalSheetTourPlanState();
}

class _ModalSheetTourPlanState extends State<ModalSheetTourPlan> {
  bool isActivitySelected = false;
  String activity = "";
  String detail = "";

  setIsActivitySelected(String activity) {
    setState(() {
      isActivitySelected = true;
      this.activity = activity;
      widget.setActivity(activity);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Text("Select Activity For ${widget.todayText}"),
              Expanded(
                child: Container(),
              ),
              GestureDetector(
                onTap: () {
                  widget.setIsModalFalse();
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black.withOpacity(0.1),
          thickness: 2,
        ),
        Expanded(
            child: isActivitySelected
                ? SelectedList(widget.todayText, activity, widget.setDetail, widget.index, widget.setIsModalFalse, widget.setTourPlan)
                : ActivityList(setIsActivitySelected)),
      ],
    );
  }
}
