import 'package:flutter/material.dart';

class BezierHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 8),
      child: Text(
        "Category Wise Order",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
