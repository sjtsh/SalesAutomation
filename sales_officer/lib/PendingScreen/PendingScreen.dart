import 'package:flutter/material.dart';

import '../Database.dart';
import 'SingularPending.dart';

class PendingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Pending Orders ",
              style: TextStyle(backgroundColor: Color(0xffF5F5F5)),
            ),
          ),
          Column(
            children: forPending
                .where((element) => element[3])
                .map(
                  (e) => SingularPending(e),
                )
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Approved Orders ",
              style: TextStyle(backgroundColor: Color(0xffF5F5F5)),
            ),
          ),
          Column(
            children: forPending
                .where((element) => !element[3])
                .map(
                  (e) => SingularPending(e),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}
