import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_officer/ConfirmationScreen/ConfirmationScreen.dart';
import 'package:sales_officer/DialogBox/DialogBox.dart';

import 'NavBar.dart';

class ConfirmOrder extends StatefulWidget {
  final Function _setIndex;

  ConfirmOrder(this._setIndex);

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return ConfirmationScreen();
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
