import 'package:flutter/material.dart';
import 'package:sales_officer/Notification/NotificationsList.dart';

import '../Header.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Column(
          children: [
            Header(5, false),
            NotificationList(),
          ],
        ),
      ),
    );
  }
}
