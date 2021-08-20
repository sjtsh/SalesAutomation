import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_officer/ActivationCode/ActivateButtton.dart';

import 'EnterActivation.dart';

class ActivationCode extends StatelessWidget {
  const ActivationCode({Key? key}) : super(key: key);

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
          EnterActivation(),
          SizedBox(
            height: 50,
          ),
          ActivateButton(),
          Expanded(child: Container()),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
