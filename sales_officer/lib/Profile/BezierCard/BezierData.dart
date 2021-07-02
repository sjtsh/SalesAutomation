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

class BezierData extends StatelessWidget {
  final ExpandableController _expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      collapsed: Column(
        children: [
          Column(
            children: products
                .sublist(0, 4)
                .map((item) => ExpandableHeader(item))
                .toList(),
          ),
          ExpandableButton(
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
            children: products.map((item) => ExpandableHeader(item)).toList(),
          ),
          ExpandableButton(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("SEE ALL"),
            ),
          )
        ],
      ),
      controller: _expandableController,
    );
  }
}
