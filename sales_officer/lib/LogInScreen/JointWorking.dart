import 'package:flutter/material.dart';
import 'package:sales_officer/Database.dart';

import '../LeaveScreen.dart';

class JointWorking extends StatelessWidget {
  final Function select;

  JointWorking(this.select);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
        color: Colors.white,
          child: InkWell(
            onTap: () {
              select();
              isJoint = false;
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black.withOpacity(0.1)),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Start Retailing",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              select();
              isJoint = true;
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black.withOpacity(0.1)),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Joint Working",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_){
              return LeaveScreen();
            }));
            },
            child: Container(
              height: 60,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Leave/week off",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Expanded(child: Container()),
                  Icon(Icons.arrow_forward, color: Colors.black),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
