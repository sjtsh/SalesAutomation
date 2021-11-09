import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';
import 'package:sales_officer/SignIn/SignIn.dart';
import 'package:sales_officer/syncLogo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BACKEND Access/Methods/calculateSales.dart';
import 'BACKEND Access/Methods/calculateWeeklySales.dart';
import 'Database.dart';

void main() {
  runApp(Fusers());
}

class Fusers extends StatefulWidget {
  @override
  _FusersState createState() => _FusersState();
}

class _FusersState extends State<Fusers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(fontFamily: "lato"),
      routes: {
      },
      title: 'Fusers',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              SharedPreferences prefs = snapshot.data;
              meSOID = prefs.getInt('meSOID') ?? 0;

              if (meSOID! > 0) {
                return LogInScreen();
              } else {
                return SafeArea(
                  child: Scaffold(
                    backgroundColor: Color(0xffF5F5F5),
                    body: SignIn(),
                  ),
                );
              }
            }
            return SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xffF5F5F5),
                body: SignIn(),
              ),
            );
          }),
    );
  }
}
