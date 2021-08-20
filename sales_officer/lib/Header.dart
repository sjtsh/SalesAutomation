import 'package:flutter/material.dart';
import 'package:sales_officer/Notification/NotificationScreen.dart';

List heading = [
  "Distributor",
  "Stocks",
  "New Order",
  "Orders",
  "Dashboard",
  "Notifications",
];

class Header extends StatelessWidget {
  final int index;
  final bool condition;

  Header(this.index, this.condition);

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
          InkWell(
            onTap: () {
              if (condition) {
                Scaffold.of(context).openDrawer();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Ink(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(condition ? Icons.menu : Icons.arrow_back),
              ),
            ),
          ),
          Text(
            heading[index],
          ),
          Expanded(
            child: Container(),
          ),
          GestureDetector(
            onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(Icons.notifications_active_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
