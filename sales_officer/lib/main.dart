import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_officer/SignIn/SignIn.dart';


void main() {
  // runApp(SalesOfficer());
  runApp(Fusers());
}

class Fusers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  SystemChrome.setEnabledSystemUIOverlays([]);
  return MaterialApp(
      title: 'Fusers',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: SignIn(),
      ),
    );
  }
}
