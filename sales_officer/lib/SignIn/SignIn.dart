import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location/location.dart';

import 'SignInButton.dart';
import 'SignInCodeButton.dart';
import 'SignInCred.dart';

class SignIn extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Container()),
        SvgPicture.asset(
          "icons/logo.svg",
        ),
        SizedBox(
          height: 30,
        ),
        SignInCred(_formKey, _username, _password),
        SizedBox(
          height: 50,
        ),
        SignInButton(_formKey, _username, _password),
        SizedBox(
          height: 10,
        ),
        SignInCodeButton(),
        Expanded(
          child: Container(),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
