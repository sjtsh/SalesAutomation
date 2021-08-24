import 'package:flutter/material.dart';
import 'package:sales_officer/HomeScreen.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';

class SignInButton extends StatelessWidget {

  final _formKey;
  final TextEditingController _username;
  final TextEditingController _password;

  SignInButton(this._formKey, this._username, this._password);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: MaterialButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {

          // final username = _username.text;
          // final password = _password.text;
          //
          // if(_formKey.currentState!.validate()){
          //   print("username: $username \npassword: $password");
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => HomeScreen()),
          //   );
          // }
          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogInScreen()),
                );
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red,
          ),
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
