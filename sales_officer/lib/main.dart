import 'dart:convert';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Database.dart';
import 'LogInScreen/LogInScreen.dart';
import 'SignIn/SignIn.dart';

Future<void> main() async {
  runApp(Fusers());
  AndroidAlarmManager.initialize();
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
      routes: {},
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
