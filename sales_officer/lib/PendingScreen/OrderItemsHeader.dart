import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class OrderItemsHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandableButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5.0, horizontal: 12),
            child: Row(
              children: [
                Text("Order List"),
                Expanded(
                  child: Container(),
                ),
                Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.black.withOpacity(0.1),
          thickness: 1,
        ),
      ],
    );
  }
}
