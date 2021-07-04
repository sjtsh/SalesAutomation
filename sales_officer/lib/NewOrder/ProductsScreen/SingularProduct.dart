import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/Database.dart';

import 'SingularProductHeader.dart';
import 'SingularProductVariation.dart';

class SingularProduct extends StatelessWidget {
  final item;

  SingularProduct(this.item);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      collapsed: ExpandableButton(
        child: SingularProductHeader(item),
      ),
      expanded: Column(
        children: [
          ExpandableButton(
            child: SingularProductHeader(item),
          ),
          Column(
            children: productVariations
                .map((item) => SingularProductVariation(item))
                .toList(),
          ),
        ],
      ),
    );
  }
}
