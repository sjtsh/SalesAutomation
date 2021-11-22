import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';
import 'package:sales_officer/Database.dart';
import 'package:sales_officer/DistributorList/DistributorList.dart';
import 'package:sales_officer/MoreScreen/ActivitiesScreen/DistributorLists.dart';
import 'package:timelines/timelines.dart';

import '../../Header.dart';

class ActivitiesScreen extends StatefulWidget {
  final Function refresh;

  ActivitiesScreen(this.refresh);

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  bool onTapped = false;

  tap(bool notTapped) {
    setState(() {
      onTapped = !notTapped;
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
                  Padding(
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
                          onTap: () {},
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
                                    Icon(Icons.keyboard_arrow_down_sharp)
                                  ],
                                ),
                                Column(
                                  children: personalDistributorsLocal
                                      .map((e) =>
                                          DistributorLists(tap, onTapped, e))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
