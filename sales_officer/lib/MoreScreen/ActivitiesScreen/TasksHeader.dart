import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import 'package:sales_officer/Database.dart';

import 'TasksList.dart';

class TasksHeader extends StatefulWidget {
  final Function expand;
  final String currentExpanded;
  final Function tap;
  final int onTapped;

  TasksHeader(
    this.expand,
    this.currentExpanded,
    this.tap,
    this.onTapped,
  );

  @override
  _TasksHeaderState createState() => _TasksHeaderState();
}

class _TasksHeaderState extends State<TasksHeader> {
  String currentlyExpanded = "";

  expanded(String currentlyExpanded) {
    setState(() {
      if (this.currentlyExpanded == currentlyExpanded) {
        this.currentlyExpanded = "";
      } else {
        this.currentlyExpanded = currentlyExpanded;
      }
    });
  }

  final ExpandableController _expandableControllerMain = ExpandableController();

  @override
  Widget build(BuildContext context) {
    if (widget.currentExpanded == "Tasks") {
      _expandableControllerMain.expanded = true;
    } else {
      _expandableControllerMain.expanded = false;
    }
    return ExpandablePanel(
      controller: _expandableControllerMain,
      collapsed: Padding(
        padding: EdgeInsets.only(bottom: 12, left: 12, right: 12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, 2))
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                widget.expand("Tasks");
                _expandableControllerMain.expanded =
                    !_expandableControllerMain.expanded;
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child: Text("Tasks")),
                    Icon(Icons.keyboard_arrow_down_sharp)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      expanded: Padding(
        padding: EdgeInsets.only(bottom: 12, left: 12, right: 12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, 2))
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                widget.expand("Tasks");
                _expandableControllerMain.expanded =
                    !_expandableControllerMain.expanded;
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text("Tasks")),
                        Icon(Icons.keyboard_arrow_up)
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Column(
                      children: allTaskLocal
                          .map((element) =>
                              TasksList(element, widget.tap, widget.onTapped))
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
