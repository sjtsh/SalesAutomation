import 'package:flutter/material.dart';

import 'SelectBeat.dart';

class JointWorking extends StatelessWidget {
  final Function select;

  JointWorking(this.select);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            select();
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black.withOpacity(0.1)),
              ),
              color: Colors.white,
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
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black.withOpacity(0.1)),
              ),
              color: Colors.white,
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
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
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
      ],
    );
  }
}
