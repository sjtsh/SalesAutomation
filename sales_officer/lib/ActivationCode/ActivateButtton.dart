import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/login.dart';
import 'package:sales_officer/BACKEND%20Access/Services/ActivationCodeService.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Database.dart';

class ActivateButton extends StatelessWidget {
  final bool _isTyped;
  final int codeHere;

  ActivateButton(this._isTyped, this.codeHere);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, left: 32, top: 5),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _isTyped ? Colors.red : Colors.black.withOpacity(0.1),
        ),
        child: MaterialButton(
          onPressed: () {
            ActivationCodeService activationCodeService =
                ActivationCodeService();

            activationCodeService.fetchActivationCodes().then((codes) {
              try {
                meSOID = codes
                    .firstWhere((element) =>
                        element.codeID == codeHere && element.post == "SO")
                    .postID;

                SharedPreferences.getInstance().then(((prefs) {
                  prefs.setInt('meSOID', meSOID!);
                }));

                logIn(context);
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Incorrect code")));
              }
            });
          },
          child: Center(
            child: Text(
              "Activate",
              style: TextStyle(
                  color: _isTyped ? Colors.white : Colors.black, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
