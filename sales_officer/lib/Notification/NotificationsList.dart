import 'package:flutter/material.dart';
import 'package:sales_officer/Notification/IndividualNotification.dart';

List<String> messages = List.generate(7, (index) => "Notification $index");

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List<bool> _isSeen = List.generate(7, (index) => false);

  setSeen(int index) {
    setState(() {
      _isSeen[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: messages
          .map((e) =>
              IndividualNotification(e, setSeen, _isSeen[messages.indexOf(e)]))
          .toList(),
    );
  }
}
