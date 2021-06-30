import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_officer/SignIn/SignIn.dart';

import 'HomeScreen/HomeScreen.dart';

void main() {
  // runApp(SalesOfficer());
  runApp(SalesOfficer());
}

class SalesOfficer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SalesOfficer',
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
