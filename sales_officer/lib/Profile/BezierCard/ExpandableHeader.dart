import 'dart:core';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/Profile/BezierCard/DataDetails.dart';

class ExpandableHeader extends StatefulWidget {

  final List listOfProducts;
  final List item;
  final bool isMTD;

  ExpandableHeader(this.listOfProducts, this.item, this.isMTD);

  @override
  _ExpandableHeaderState createState() => _ExpandableHeaderState();
}

class _ExpandableHeaderState extends State<ExpandableHeader> {
  List<bool> value = [];

  expanded(int index, bool isChecked) {
    setState(
          () {
        value[index] = isChecked;
      },
    );
  }
  List<String> expandedDetails = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(
            top: 16.0, right: 8, left: 8, bottom: 2),
        child: Row(
          children: [
            Text(
                (widget.listOfProducts.indexOf(widget.item)+1).toString() + "."
            ),
            SizedBox(
              width: 10,
            ),
            DataDetails(widget.item),
            Text(
              "Rs. ${widget.isMTD ? widget.item[1][0]: widget.item[1][1]}",
            ),
          ],
        ),
      ),
    );
  }
}
