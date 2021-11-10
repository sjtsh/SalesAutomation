import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, right: 12),
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xffe8e8e8),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, right: 200),
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(colors: [Color(0xff5A6FF0), Color(0xffC31FE6)]),
          ),
        ),
      ],
    );
  }
}
