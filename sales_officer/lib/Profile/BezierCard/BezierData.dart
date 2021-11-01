import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/Profile/BezierCard/ExpandableHeader.dart';

import '../../Database.dart';

// ExpandablePanel(
// header: Text(article.title),
// collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
// expanded: Text(article.body, softWrap: true, ),
// tapHeaderToExpand: true,
// hasIcon: true,
// );

class BezierData extends StatefulWidget {
  final _expandableController;
  final Function changeExpanded;
  final bool isMTD;

  BezierData(this._expandableController, this.changeExpanded, this.isMTD);

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
    print(listOfProducts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      collapsed: Column(
        children: [
          Column(
            children: listOfProducts.length > 4
                ? listOfProducts
                    .sublist(0, 4)
                    .map((item) => ExpandableHeader(listOfProducts, item, widget.isMTD))
                    .toList()
                : listOfProducts
                    .map((item) => ExpandableHeader(listOfProducts, item, widget.isMTD))
                    .toList(),
          ),
          InkWell(
            onTap: () {
              widget.changeExpanded(true);
              widget._expandableController.expanded = true;
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
          Column(
            children: listOfProducts
                .map((item) => ExpandableHeader(listOfProducts, item, widget.isMTD))
                .toList(),
          ),
          InkWell(
            onTap: () {
              widget._expandableController.expanded = false;
              Future.delayed(Duration(milliseconds: 400)).then((value) {
                widget.changeExpanded(false);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("SEE ALL"),
            ),
          ),
        ],
      ),
      controller: widget._expandableController,
    );
  }
}
