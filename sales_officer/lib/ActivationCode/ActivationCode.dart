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
  int codeHere = 0;
  void setTyped(String input) {
    setState(() {
      if (input.length == 5) {
        try {
          codeHere = int.parse(input);
          _isTyped = true;
        } catch (e) {
          _isTyped = false;
        }
      } else {
        _isTyped = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
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
            ActivateButton(_isTyped, codeHere),
            Expanded(child: Container()),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
