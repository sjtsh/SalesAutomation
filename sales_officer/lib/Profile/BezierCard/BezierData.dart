import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/Profile/BezierCard/BexierChartnData.dart';
import 'package:sales_officer/Profile/BezierCard/ExpandableHeader.dart';

import '../../Database.dart';
import 'BezierChartPersonal.dart';

class BezierData extends StatefulWidget {
  final _expandableController;
  final Function changeExpanded;
  final bool isMTD;
  final bool toggleValue;

  BezierData(this._expandableController, this.changeExpanded, this.isMTD,
      this.toggleValue);

  @override
  _BezierDataState createState() => _BezierDataState();
}

class _BezierDataState extends State<BezierData> {
  List listOfProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    products.forEach((key, value) {
      listOfProducts.add([key, value]);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      collapsed: Column(
        children: [
          Builder(builder: (context) {
            if (widget.isMTD) {
              if (listOfProducts.length > 4) {
                return Column(
                  children: listOfProducts
                      .where((element) => !(element[1][0] == 0))
                      .toList()
                      .sublist(0, 4)
                      .map((item) =>
                          ExpandableHeader(listOfProducts, item, widget.isMTD))
                      .toList(),
                );
              } else {
                return Column(
                  children: listOfProducts
                      .where((element) => !(element[1][0] == 0))
                      .toList()
                      .map((item) =>
                          ExpandableHeader(listOfProducts, item, widget.isMTD))
                      .toList(),
                );
              }
            } else {
              listOfProducts.sort((a, b) => b[1][0].compareTo(a[1][0]));
              if (listOfProducts.length > 4) {
                return Column(
                  children: listOfProducts
                      .where((element) => !(element[1][1] == 0))
                      .toList()
                      .sublist(0, 4)
                      .map((item) =>
                          ExpandableHeader(listOfProducts, item, widget.isMTD))
                      .toList(),
                );
              } else {
                return Column(
                  children: listOfProducts
                      .where((element) => !(element[1][1] == 0))
                      .toList()
                      .map((item) =>
                          ExpandableHeader(listOfProducts, item, widget.isMTD))
                      .toList(),
                );
              }
            }
          }),
          InkWell(
            onTap: () {
              // widget.changeExpanded(true);
              // widget._expandableController.expanded = true;
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return Scaffold(
                    body: BezierChartnData(
                        widget.isMTD,
                        widget._expandableController,
                        widget.changeExpanded,
                        widget.toggleValue));
              }));
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("SEE ALL"),
            ),
          ),
        ],
      ),
      expanded: Column(
        children: [
          Builder(builder: (context) {
            if (widget.isMTD) {
              return Column(
                children: listOfProducts
                    .where((element) => !(element[1][0] == 0))
                    .toList()
                    .map((item) =>
                        ExpandableHeader(listOfProducts, item, widget.isMTD))
                    .toList(),
              );
            } else {
              listOfProducts.sort((a, b) => b[1][0].compareTo(a[1][0]));
              return Column(
                children: listOfProducts
                    .where((element) => !(element[1][1] == 0))
                    .toList()
                    .map((item) =>
                        ExpandableHeader(listOfProducts, item, widget.isMTD))
                    .toList(),
              );
            }
          }),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              widget._expandableController.expanded = false;
              Future.delayed(Duration(milliseconds: 400)).then((value) {
                widget.changeExpanded(false);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("SEE LESS"),
            ),
          ),
        ],
      ),
      controller: widget._expandableController,
    );
  }
}
