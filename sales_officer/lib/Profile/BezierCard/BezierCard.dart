import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/Profile/BezierCard/BexierChartnData.dart';
import 'package:sales_officer/Profile/BezierCard/BezierChartPersonal.dart';

import '../../Database.dart';
import 'BezierData.dart';
import 'BezierHeading.dart';

class BezierCard extends StatefulWidget {
  final bool toggleValue;

  BezierCard(
    this.toggleValue,
  );
  @override
  _BezierCardState createState() => _BezierCardState();
}

class _BezierCardState extends State<BezierCard> {
  ExpandableController _expandableController = ExpandableController();
  int pageNumber = 0;
  bool aCondition = false;

  void changeExpanded(bool condition) {
    setState(() {
      aCondition = condition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: !aCondition
          ? 382.0
          : 382.0 +
              41 *
                  (products.entries
                          .where((element) => !(element.value[pageNumber] == 0))
                          .length -
                      4),
      child: PageView(
        onPageChanged: (int i) {
          pageNumber = i;
          _expandableController.expanded = false;
          Future.delayed(Duration(milliseconds: 500), () {
            changeExpanded(false);
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
                   BezierChartnData(e,_expandableController,changeExpanded,widget.toggleValue),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
