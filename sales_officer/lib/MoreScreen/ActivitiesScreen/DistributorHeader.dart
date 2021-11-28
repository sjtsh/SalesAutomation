import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import 'package:sales_officer/Database.dart';
import 'package:sales_officer/MoreScreen/ActivitiesScreen/DistributorLists.dart';

class DistributorHeader extends StatefulWidget {
  final Function expand;
  final String currentExpanded;

  DistributorHeader(this.expand, this.currentExpanded);

  @override
  _DistributorHeaderState createState() => _DistributorHeaderState();
}

class _DistributorHeaderState extends State<DistributorHeader> {
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

  int onTapped = 0;

  tap(int notTapped) {
    setState(() {
      onTapped = notTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentExpanded == "Distributor Lists") {
      _expandableControllerMain.expanded = true;
    } else {
      _expandableControllerMain.expanded = false;
    }
    return ExpandablePanel(
      controller: _expandableControllerMain,
      collapsed: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Container(
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
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                widget.expand("Distributor Lists");
                _expandableControllerMain.expanded =
                    !_expandableControllerMain.expanded;
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child: Text("Distributor Lists")),
                    Icon(Icons.keyboard_arrow_down_sharp),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      expanded: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Container(
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
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                widget.expand("Distributor Lists");
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
                        Expanded(
                          child: Text("Distributor Lists"),
                        ),
                        Icon(Icons.keyboard_arrow_up),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Column(
                      children: personalDistributorsLocal
                          .asMap()
                          .entries
                          .map((element) => DistributorLists(
                              element.value, tap, onTapped, element.key))
                          .toList(),
                    ),
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
