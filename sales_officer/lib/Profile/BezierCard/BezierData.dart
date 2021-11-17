import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/Profile/BezierCard/BezierChartPersonal.dart';
import 'package:sales_officer/Profile/BezierCard/ExpandableHeader.dart';
import 'package:sales_officer/Profile/BezierCard/SeeAllSalesScreen.dart';
import '../../Database.dart';

class BezierData extends StatefulWidget {
  final Function changeExpanded;
  final bool isMTD;
  final bool toggleValue;
  final Function refresh;

  BezierData(this.changeExpanded, this.isMTD,
      this.toggleValue, this.refresh);

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
    return Column(
        children: [
          Builder(builder: (context) {
            if (widget.isMTD) {
              if (listOfProducts.where((element) => !(element[1][0] == 0)).length > 4) {
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
              if (listOfProducts.where((element) => !(element[1][1] == 0)).length > 4) {
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
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return SeeAllSalesScreen(widget.isMTD,widget.refresh,widget.toggleValue,listOfProducts);
              }));
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("SEE ALL"),
            ),
          ),
        ],
    );
  }
}
