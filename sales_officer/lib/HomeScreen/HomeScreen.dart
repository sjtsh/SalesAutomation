import 'package:flutter/material.dart';
import 'package:sales_officer/Construction/Construction.dart';
import 'package:sales_officer/Header/Header.dart';
import 'package:sales_officer/NavBar/NavBar.dart';
import 'package:sales_officer/Pages/Page1.dart';
import 'package:sales_officer/Pages/Page2.dart';
import 'package:sales_officer/Pages/Page3.dart';
import 'package:sales_officer/Pages/Page4.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int i = 0;

  _setIndex(int i) {
    setState(() {
      this.i = i;
    });
  }

  Widget _changeActivity(int i) {
    if (i == 0) {
      return Page1();
    } else if (i == 1) {
      return Page2();
    } else if (i == 2) {
      return Page3();
    } else if (i == 3) {
      return Page4();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Stack(
          children: [
            _changeActivity(i),
            NavBar(_setIndex),
          ],
        ),
      ),
    );
  }
}
