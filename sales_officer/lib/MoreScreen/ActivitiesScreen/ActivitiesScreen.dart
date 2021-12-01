import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SOActivity.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SOActivityService.dart';
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
  TextEditingController controller = TextEditingController();
  int onDistributorTapped = 0;
  int onTaskTapped = 0;
  bool isLoaded = true;

  distributorTap(int notTapped) {
    setState(() {
      onDistributorTapped = notTapped;
    });
  }

  taskTap(int notTapped) {
    setState(() {
      onTaskTapped = notTapped;
    });
  }

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
                  DistributorHeader(expand, currentExpanded, distributorTap,
                      onDistributorTapped),
                  TasksHeader(expand, currentExpanded, taskTap, onTaskTapped),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12, left: 12, right: 12),
                    child: TextField(
                      controller: controller,
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
                child: isLoaded
                    ? MaterialButton(
                        onPressed: () {
                          setState(() {
                            isLoaded = false;
                          });
                          SOActivityService()
                              .insertSOActivity(meSOID!, onDistributorTapped,
                                  onTaskTapped, controller.text)
                              .then((value) {
                            if (value) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Thank you for keeping update"),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Activity could not be added. Please try again"),
                                ),
                              );
                            }
                            setState(() {
                              isLoaded = true;
                            });
                          });
                        },
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
                      )
                    : MaterialButton(
                        onPressed: () {},
                        child: Container(
                          height: 50,
                          width: 180,
                          child: Builder(builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
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
