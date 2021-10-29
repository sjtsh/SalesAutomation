import 'package:flutter/material.dart';
import 'package:sales_officer/DialogBox/DiscardPrompt.dart';
import 'package:sales_officer/Notification/NotificationScreen.dart';
import 'package:sales_officer/syncLogo.dart';

import 'BACKEND Access/Methods/loadLocalData.dart';

List heading = [
  "Dashboard", //0
  "Distributors", //1
  "Orders", //2
  "More", //3
  "Tour Plan", //4
  "Notifications", //5
  "Edit Order", //6
  "Create Order", //7
  "Update Stock", //8
  "Settings", //9
  "FAQ" //10
];

class Header extends StatefulWidget {
  final int index;
  final bool isNotBackIcon;
  final Function refresh;

  Header(this.index, this.isNotBackIcon, this.refresh);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

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
          widget.isNotBackIcon
              ? SizedBox(
                  width: 12,
                )
              : Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      if (widget.isNotBackIcon) {
                      } else {
                        if (widget.index == 6 ||
                            widget.index == 7 ||
                            widget.index == 8) {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return DiscardPrompt();
                            },
                          );
                        } else {
                          Navigator.of(context).pop();
                        }
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
            heading[widget.index],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Container(),
          ),
          SyncIcon(widget.refresh, widget.isNotBackIcon),
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                if (widget.isNotBackIcon) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen(widget.refresh)));
                }
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: widget.isNotBackIcon
                    ? Center(
                        child: Icon(
                          Icons.notifications_active_outlined,
                        ),
                      )
                    : Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
