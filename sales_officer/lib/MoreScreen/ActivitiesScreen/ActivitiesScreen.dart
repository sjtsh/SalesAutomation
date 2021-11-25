import 'package:flutter/material.dart';
import 'package:sales_officer/Database.dart';
import 'package:sales_officer/MoreScreen/ActivitiesScreen/DistributorHeader.dart';
import 'package:sales_officer/MoreScreen/ActivitiesScreen/TasksHeader.dart';

import '../../Header.dart';

class ActivitiesScreen extends StatefulWidget {
  final Function refresh;

  ActivitiesScreen(this.refresh);

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  String currentExpanded = "";

  expand(String currentExpanded) {
    setState(() {
      if (this.currentExpanded == currentExpanded) {
        this.currentExpanded = "";
      } else {
        this.currentExpanded = currentExpanded;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(16, false, widget.refresh),
            Expanded(
              child: ListView(
                children: [
                  DistributorHeader(expand, currentExpanded),
                  TasksHeader(expand, currentExpanded),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12, left: 12, right: 12),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Custom Message',
                        hintText: 'Remark',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red),
                ),
                child: MaterialButton(
                  onPressed: () {},
                  child: Container(
                    height: 50,
                    width: 180,
                    child: Builder(builder: (context) {
                      return Center(
                        child: Text(
                          "Start Work",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
