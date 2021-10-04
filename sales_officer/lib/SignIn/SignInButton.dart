import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sales_officer/BACKEND/Methods/login.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';

import '../HomeScreen.dart';

class SignInButton extends StatefulWidget {
  final _formKey;
  final TextEditingController _username;
  final TextEditingController _password;

  SignInButton(this._formKey, this._username, this._password);

  @override
  _SignInButtonState createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red,
        ),
        child: MaterialButton(
          onPressed: () async {
            final username = widget._username.text;
            final password = widget._password.text;
            // logIn(context, widget._formKey);
          },
          child: Center(
            child: Text(
              "Log In",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
