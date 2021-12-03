import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/Profile/BezierCard/BezierChartPersonal.dart';
import 'package:sales_officer/Profile/BezierCard/BezierChartPersonal.dart';

import '../../Database.dart';
import 'BezierData.dart';
import 'BezierHeading.dart';

class BezierCard extends StatefulWidget {
  final bool toggleValue;
  final Function refresh;

  BezierCard(
    this.toggleValue,
    this.refresh,
  );

  @override
  _BezierCardState createState() => _BezierCardState();
}

class _BezierCardState extends State<BezierCard> {
  int pageNumber = 0;
  bool aCondition = false;
  bool isMTD = true;

  PageController _pageController = PageController();

  void changeExpanded(bool condition) {
    setState(() {
      aCondition = condition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: !aCondition
              ? 382.0
              : 382.0 +
                  41 *
                      (products.entries
                              .where((element) => !(element.value[pageNumber] == 0))
                              .length -
                          4),
          child: PageView(
            pageSnapping: true,
            controller: _pageController,
            onPageChanged: (int i) {
              pageNumber = i;
              Future.delayed(Duration(milliseconds: 500), () {
                changeExpanded(false);
              });
              setState(() {
                isMTD = !isMTD;
              });
            },
            scrollDirection: Axis.horizontal,
            children: [true, false]
                .map(
                  (e) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            offset: Offset(0, 2))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 6,
                        ),
                        BezierHeading(e ? "MTD Sales" : "YTD Sales"),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          height: 100,
                          child: Hero(
                            tag: "sajat",
                            child: BezierChartPersonal(
                                e ? weeklySalesLocal : monthlySalesLocal,
                                widget.toggleValue),
                          ),
                        ),
                        BezierData(changeExpanded, e, widget.toggleValue,
                            widget.refresh),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isMTD
                      ? Colors.black.withOpacity(0.5)
                      : Colors.black.withOpacity(0.3)),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color:isMTD ? Colors.black.
              withOpacity(0.3) :Colors.black.withOpacity(0.5)),
            ),
          ],
        ),
      ],
    );
  }
}
