import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
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
          onPressed: () async {
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
            LocationPermission permission = await Geolocator.checkPermission();
            if (permission == LocationPermission.denied) {
              permission = await Geolocator.requestPermission();
              if (permission == LocationPermission.denied) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(minutes: 2),
                    content: Text('Location permissions are denied'),
                  ),
                );
                return Future.error('Location permissions are denied');
              }
            }

            if (permission == LocationPermission.deniedForever) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(minutes: 2),
                  content: Text('Location permissions are denied'),
                ),
              );
              return Future.error(
                  'Location permissions are permanently denied, we cannot request permissions.');
            }

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
