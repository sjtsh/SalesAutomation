import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderService.dart';
import 'package:sales_officer/PendingScreen/OrdersList.dart';
import 'package:sales_officer/Skeletons/PendingOrderSkeleton.dart';
import 'package:shimmer/shimmer.dart';

import '../Database.dart';

List headers = ["Pending Orders", "Approved Orders"];

class PendingScreen extends StatefulWidget {
  final DistributorOrderService distributorOrderService =
      DistributorOrderService();

  final Function refresh;

  PendingScreen(this.refresh);

  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  int index = 0;
  bool isTabPending = true;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
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
                      pageController.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black.withOpacity(0.1)),
                        bottom: BorderSide(
                          color: isTabPending
                              ? Colors.blue
                              : Colors.black.withOpacity(0.1),
                          width: 2,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "PENDING",
                        style: TextStyle(
                            color: isTabPending
                                ? Colors.blue
                                : Colors.black.withOpacity(0.5)),
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
                      pageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black.withOpacity(0.1)),
                        bottom: BorderSide(
                          color: isTabPending
                              ? Colors.black.withOpacity(0.1)
                              : Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "APPROVED",
                        style: TextStyle(
                            color: isTabPending
                                ? Colors.black.withOpacity(0.5)
                                : Colors.blue),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: widget.distributorOrderService
                  .fetchDistributorOrders(context),
              builder: (BuildContext context,
                  AsyncSnapshot<List<DistributorOrder>> snapshot) {
                if (snapshot.hasData) {
                  List<DistributorOrder> distributorOrders = snapshot.data!
                      .where((element) =>
                          (element.SOID == meSO!.SOID) && !element.deactivated)
                      .toList();
                  return PageView(
                    onPageChanged: (int i) {
                      setState(() {
                        if (i == 1) {
                          isTabPending = false;
                        } else if (i == 0) {
                          isTabPending = true;
                        }
                      });
                    },
                    controller: pageController,
                    children: [
                      OrdersList(distributorOrders, false, widget.refresh),
                      OrdersList(distributorOrders, true, widget.refresh)
                    ],
                  );
                }
                return PageView(
                  onPageChanged: (int i) {
                    setState(() {
                      if (i == 1) {
                        isTabPending = false;
                      } else if (i == 0) {
                        isTabPending = true;
                      }
                    });
                  },
                  controller: pageController,
                  children: ["", ""]
                      .map((e) => ListView(
                          children: List.generate(
                              7,
                              (index) => Shimmer(
                                  gradient: LinearGradient(
                                      colors: [Colors.white, Colors.grey]),
                                  child: PendingOrderSkeleton())).toList()))
                      .toList(),
                );
              }),
        ),
      ],
    );
  }
}
