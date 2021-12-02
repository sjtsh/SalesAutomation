import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SOActivity.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SOLogInDetail.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/NepaliDateService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUStockService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SOActivityService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SOLogInDetailService.dart';
import 'package:timelines/timelines.dart';

import 'ActivityWidgets.dart';
import 'InnerTimeline.dart';

class DeliveryProcesses extends StatelessWidget {
  final List content = [
    [
      "",
      "",
      Container(),
    ],
    [
      "Day Start",
      "09:30 AM",
      LogInOutActivity(true, 1, 1),
    ],
    [
      "Distributor Order",
      "11:30 AM",
      OrderStockActivity(true, "New Bhatbhateni", 235232.3, 21),
    ],
    [
      "Distributor Stock",
      "12:47 PM",
      OrderStockActivity(false, "Hamro Store", 12321.1, 45),
    ],
    [
      "Day End",
      "06:30 PM",
      LogInOutActivity(false, 1, 1),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: NepaliDateService().fetchNepaliDate().then((date) {
          DistributorOrderService()
              .fetchDistributorOrders(context)
              .then((allOrders) {
            SKUStockService().fetchSKUStocks().then((allStocks) {
              SOLogInDetailService().fetchSOLogInDetails().then((allDetails) {
                SOActivityService().fetchSOActivitys().then((allActivity) {
                  Map ActivityByTime = {};
                  List<DistributorOrder> allOrdersToday = allOrders
                      .where((element) =>
                          element.dateAndTime.substring(0, 10) ==
                          date.substring(0, 10))
                      .toList();
                  // List<SKUStock> allStocksToday = allStocks.where((element) =>
                  // element.updatedDate.substring(0, 10) == date.substring(0, 10))
                  //     .toList();
                  List<SOLogInDetail> allDetailsToday = allDetails
                      .where((element) =>
                          element.date.substring(0, 10) ==
                          date.substring(0, 10))
                      .toList();
                  List<SOActivity> allActivities = allActivity
                      .where((element) =>
                          element.dateAndTime.substring(0, 10) ==
                          date.substring(0, 10))
                      .toList();
                });
              });
            });
          });
        }),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return DefaultTextStyle(
              style: TextStyle(
                color: Color(0xff9b9b9b),
                fontSize: 12.5,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FixedTimeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: 0,
                    color: Colors.white,
                    nodeItemOverlap: true,
                    indicatorPosition: -3,
                    indicatorTheme: IndicatorThemeData(
                        position: 0, size: 22.0, color: Colors.white),
                    connectorTheme: ConnectorThemeData(
                      thickness: 2.5,
                    ),
                  ),
                  builder: TimelineTileBuilder.connected(
                    connectionDirection: ConnectionDirection.before,
                    itemCount: content.length + 1,
                    contentsBuilder: (_, index) {
                      return index != 0 && index != 5
                          ? Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        content[index][0],
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .copyWith(
                                                fontSize: 16.0,
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                      ),
                                      Text(
                                        "    ⚫    ",
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .copyWith(
                                                fontSize: 6.0,
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                      ),
                                      Text(
                                        content[index][1],
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .copyWith(
                                              fontSize: 16.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                  InnerTimeline(
                                      index != 0 && index != 5 ? true : false,
                                      content[index][2]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            )
                          : Container();
                    },
                    indicatorBuilder: (_, index) {
                      if (index == 0 || index == 5) {
                        return Container(
                          height: 12,
                        );
                      }
                      // else if (index % 2 == 0) {
                      //   return DotIndicator(
                      //     color: Colors.red,
                      //     child: Icon(
                      //       Icons.check,
                      //       color: Colors.white,
                      //       size: 12.0,
                      //     ),
                      //   );
                      // }
                      else {
                        return OutlinedDotIndicator(
                          backgroundColor: Colors.red,
                          borderWidth: 5.5,
                        );
                      }
                    },
                    connectorBuilder: (_, index, ___) => SolidLineConnector(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
