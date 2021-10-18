import 'package:flutter/material.dart';
import 'package:sales_officer/Notification/NotificationScreen.dart';

List heading = [
  "Dashboard",
  "Distributors",
  "Orders",
  "More",
  "Tour Plan",
  "Notifications",
  "Edit Order",
  "Create Order",
  "Update Stock",
  "Settings",
  "FAQ"
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
          condition
              ? SizedBox(
                  width: 12,
                )
              : Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      if (condition) {
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Center(child: Icon(Icons.arrow_back))),
                  ),
                ),
          Text(
            heading[index],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Container(),
          ),
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {

              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: condition
                    ? Center(
                        child: Icon(
                        Icons.sync,
                      ))
                    : Container(),
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                if (condition) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()));
                }
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: condition
                    ? Center(
                        child: Icon(
                        Icons.notifications_active_outlined,
                      ))
                    : Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
