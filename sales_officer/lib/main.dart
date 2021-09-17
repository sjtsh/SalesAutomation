import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sales_officer/BACKEND/Services/SOService.dart';
import 'package:sales_officer/SignIn/SignIn.dart';

void main() {
  runApp(Fusers());
}

class Fusers extends StatefulWidget {
  @override
  _FusersState createState() => _FusersState();
}

class _FusersState extends State<Fusers> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(fontFamily: "lato"),
      routes: {
        // '': (context) => const FirstScreen(),
      },
      title: 'Fusers',
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffF5F5F5),
          body: SignIn(),
        ),
      ),
    );
  }
}
