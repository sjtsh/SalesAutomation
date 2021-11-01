import 'package:flutter/material.dart';

import '../../Database.dart';

class ExpandableHeader extends StatelessWidget {

  final List listOfProducts;
  final List item;
  final bool isMTD;

  ExpandableHeader(this.listOfProducts, this.item, this.isMTD);

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
                (listOfProducts.indexOf(item)+1).toString() + "."
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                allSKULocal.firstWhere((element) => item[0] == element.SKUID).SKUName.substring(0,20),
              ),
            ),
            Text(
              "Rs. ${isMTD ? item[1][0]: item[1][1]}",
            ),
          ],
        ),
      ),
    );
  }
}
