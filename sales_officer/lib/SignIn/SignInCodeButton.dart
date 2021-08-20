import 'package:flutter/material.dart';
import 'package:sales_officer/ActivationCode/ActivationCode.dart';

class SignInCodeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: MaterialButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
          print("logged in with activation code");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ActivationCode()),
            );
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red)),
            child: Center(
              child: Text(
                "Already have an activation code",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          )),
    );
  }
}
