import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderService.dart';
import 'package:sales_officer/PendingScreen/OrdersList.dart';
import 'package:sales_officer/Skeletons/PendingOrderSkeleton.dart';
import 'package:shimmer/shimmer.dart';

import '../Database.dart';
import 'SingularPending.dart';

List headers = ["Pending Orders", "Approved Orders"];

class PendingScreen extends StatefulWidget {
  final DistributorOrderService distributorOrderService =
      DistributorOrderService();

  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  int index = 0;
  bool isTabPending = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.distributorOrderService.fetchDistributorOrders(),
      builder: (BuildContext context,
          AsyncSnapshot<List<DistributorOrder>> snapshot) {
        if (snapshot.hasData) {
          List<DistributorOrder> distributorOrders = [];
          snapshot.data!.forEach((element) {
            if (element.SOID == 1) {
              distributorOrders.add(element);
            }
          });
          return Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                        offset: Offset(0, 2))
                  ],
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isTabPending = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                            top: BorderSide(color: Colors.black.withOpacity(0.1)),
                              bottom: BorderSide(
                                color: isTabPending
                                    ? Colors.blue
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "PENDING",
                              style: TextStyle(color: isTabPending ? Colors.blue: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isTabPending = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.black.withOpacity(0.1)),
                              bottom: BorderSide(
                                color: isTabPending
                                    ? Colors.transparent
                                    : Colors.blue,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "APPROVED",
                              style: TextStyle(color: isTabPending ? Colors.black: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: isTabPending
                    ? OrdersList(distributorOrders, false)
                    : OrdersList(distributorOrders, true),
              ),
            ],
          );
        }
        return Container(
          decoration: BoxDecoration(
            color: Color(0xffF5F5F5),
          ),
          child: ListView(
            children: [
              SizedBox(height: 7),
              Column(
                children: List.generate(
                    2,
                    (index) => Shimmer(
                        gradient:
                            LinearGradient(colors: [Colors.white, Colors.grey]),
                        child: PendingOrderSkeleton())).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Approved Orders ",
                  style: TextStyle(backgroundColor: Color(0xffF5F5F5)),
                ),
              ),
              Column(
                children: List.generate(
                    2,
                    (index) => Shimmer(
                        gradient:
                            LinearGradient(colors: [Colors.white, Colors.grey]),
                        child: PendingOrderSkeleton())).toList(),
              ),
              SizedBox(height: 7),
            ],
          ),
        );
      },
    );
  }
}
