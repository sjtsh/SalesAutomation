import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/calculateTimeline.dart';
import 'package:sales_officer/Database.dart';
import 'package:timelines/timelines.dart';

import 'ActivityWidgets.dart';
import 'InnerTimeline.dart';

class DeliveryProcesses extends StatelessWidget {
  final String date;

  DeliveryProcesses(this.date);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: calculateTimeline(context, date),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List activityByTime = snapshot.data;
          activityByTime.sort((a, b) {
            return b[0].compareTo(a[0]);
          });
          if (activityByTime.length == 0) {
            return Center(
                child: Text(
              "No activity this day",
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ),
            ));
          } else {
            activityByTime.insert(0, ["", "", Container()]);
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
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
                        itemCount: activityByTime.length + 1,
                        contentsBuilder: (_, index) {
                          return index != 0 && index != activityByTime.length
                              ? Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Builder(builder: (context) {
                                            if (activityByTime[index][0]
                                                    .length ==
                                                19) {
                                              return Text(
                                                activityByTime[index][0]
                                                    .substring(
                                                        11,
                                                        activityByTime[index][0]
                                                            .length),
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style
                                                        .copyWith(
                                                          fontSize: 16.0,
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                        ),
                                              );
                                            } else {
                                              print("we have a error " +
                                                  activityByTime.toString());
                                              return Container();
                                            }
                                          }),
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
                                            activityByTime[index][1],
                                            style: DefaultTextStyle.of(context)
                                                .style
                                                .copyWith(
                                                  fontSize: 16.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                      InnerTimeline(
                                          index != 0 &&
                                                  index != activityByTime.length
                                              ? true
                                              : false,
                                          activityByTime[index][2]),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              : Container();
                        },
                        indicatorBuilder: (_, index) {
                          if (index == activityByTime.length) {
                            return Container(
                              height: 50,
                            );
                          } else if (index == 0) {
                            return Container(
                              height: 12,
                            );
                          } else {
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
              },
            );
          }
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                backgroundColor: Colors.black.withOpacity(0.5),
                color: Colors.black,
              ),
              SizedBox(
                height: 12,
              ),
              Text("Generating your data..."),
            ],
          ),
        );
      },
    );
  }
}
