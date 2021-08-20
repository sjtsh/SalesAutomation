import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_officer/ActivationCode/ActivateButtton.dart';

import 'EnterActivation.dart';

class ActivationCode extends StatefulWidget {
  @override
  _ActivationCodeState createState() => _ActivationCodeState();
}

class _ActivationCodeState extends State<ActivationCode> {
  bool _isTyped = false;

  void setTyped(bool condition) {
    setState(() {
      _isTyped = condition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Column(
        children: [
          Expanded(child: Container()),
          SvgPicture.asset(
            "icons/logo.svg",
          ),
          SizedBox(
            height: 30,
          ),
          EnterActivation(setTyped),
          SizedBox(
            height: 50,
          ),
          ActivateButton(_isTyped),
          Expanded(child: Container()),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
