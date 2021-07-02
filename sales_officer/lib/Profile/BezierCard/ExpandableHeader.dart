import 'package:flutter/material.dart';

import '../../Database.dart';

class ExpandableHeader extends StatelessWidget {

  final String item;

  ExpandableHeader(this.item);

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
              "${products.indexOf(item) + 1}",
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                item,
              ),
            ),
            Text(
              "Rs. ${sales[products.indexOf(item)]}",
            )
          ],
        ),
      ),
    );
  }
}
