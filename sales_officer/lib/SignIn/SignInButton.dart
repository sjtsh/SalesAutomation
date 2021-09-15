import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';

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
                MaterialPageRoute(
                  builder: (context) => LogInScreen(),
                ));
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

class LoadingScreen extends StatelessWidget {
  final String loadingText;

  LoadingScreen(this.loadingText);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("icons/logo.svg"),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                color: Colors.red,
                backgroundColor: Colors.red.withOpacity(0.5),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(loadingText),
          ],
        )),
      ),
    );
  }
}
