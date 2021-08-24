import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderService.dart';
import 'package:sales_officer/Skeletons/PendingOrderSkeleton.dart';
import 'package:shimmer/shimmer.dart';

import '../Database.dart';
import 'SingularPending.dart';

List headers = ["Pending Orders", "Approved Orders"];

class PendingScreen extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();
  final DistributorOrderService distributorOrderService =
      DistributorOrderService();

  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            headers[index],
          ),
        ),
        Expanded(
          child: FutureBuilder(
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
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                  ),
                  child: NotificationListener(
                    onNotification: (t) {
                      if (t is ScrollEndNotification) {
                        if (widget._scrollController.position.pixels >
                            160 *
                                    distributorOrders
                                        .where(
                                            (element) => !element.orderStatus)
                                        .length +
                                12) {
                          setState(
                            () {
                              index = 1;
                            },
                          );
                        } else {
                          setState(
                            () {
                              index = 0;
                            },
                          );
                        }
                        print(widget._scrollController.position.pixels);
                      }
                      return false;
                    },
                    child: ListView(
                      controller: widget._scrollController,
                      children: [
                        SizedBox(height: 7),
                        Column(
                          children: distributorOrders
                              .where((element) => !element.orderStatus)
                              .map(
                                (e) => SingularPending(e),
                              )
                              .toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Approved Orders ",
                            style:
                                TextStyle(backgroundColor: Color(0xffF5F5F5)),
                          ),
                        ),
                        Column(
                          children: distributorOrders
                              .where((element) => element.orderStatus)
                              .map(
                                (e) => SingularPending(e),
                              )
                              .toList(),
                        ),
                        SizedBox(height: 7),
                      ],
                    ),
                  ),
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
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey]),
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
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey]),
                              child: PendingOrderSkeleton())).toList(),
                    ),
                    SizedBox(height: 7),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
