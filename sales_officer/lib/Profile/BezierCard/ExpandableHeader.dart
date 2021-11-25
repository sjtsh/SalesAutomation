import 'dart:core';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';

import '../../Database.dart';

class ExpandableHeader extends StatefulWidget {
  final List listOfProducts;
  final List item;
  final bool isMTD;

  ExpandableHeader(
    this.listOfProducts,
    this.item,
    this.isMTD,
  );

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
        padding: const EdgeInsets.only(left: 12, right: 12),
        height: 40,
        child: Row(
          children: [
            Text((widget.listOfProducts
                            .where((element) => element[1][0] != 0)
                            .toList()
                            .indexOf(widget.item) +
                        1)
                    .toString() +
                "."),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                allSKULocal
                    .firstWhere((element) => widget.item[0] == element.SKUID)
                    .SKUName
                    .substring(0, 20),
              ),
            ),
            Text(
              "Rs. ${widget.isMTD ? widget.item[1][0] : widget.item[1][1]}",
            ),
          ],
        ),
      ),
    );
  }
}
