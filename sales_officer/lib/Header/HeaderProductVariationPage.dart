import 'package:flutter/material.dart';

class HeaderProductVariationPage extends StatelessWidget {
  final int index;

  HeaderProductVariationPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
              offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 12,
          ),
          Text(
            index == 0
                ? "Stocks"
                : index == 1
                    ? "Orders"
                    : index == 2
                        ? "Profile"
                        : index == 3
                            ? "Distributor"
                            : index == 4
                                ? "New Order"
                                : index == 5
                                    ? "New Order"
                                    : "Order Confirmation",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Colors.green,
            ),
          ),
          SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
