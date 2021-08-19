import 'package:flutter/material.dart';
import 'package:sales_officer/DrawerScreen/DrawerScreen.dart';
import 'package:sales_officer/Header.dart';
import 'package:sales_officer/NavBar/NavBar.dart';
import 'package:sales_officer/DistributorList/NewOrder.dart';
import 'package:sales_officer/PendingScreen/PendingScreen.dart';
import 'package:sales_officer/Profile/Profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int i = 2;

  _setIndex(int i) {
    setState(() {
      this.i = i;
    });
  }

  Future<bool> _onBackPressed() async {
    print("Back Pressed");
    NavBar.currentIndex = 2;
    _setIndex(2);
    return false;
  }
  Widget _changeActivity(int i) {
    if (i == 0) {
      return NewOrder(_setIndex, false, i);
    } else if (i == 1) {
      return NewOrder(_setIndex, true, i);
    } else if (i == 2) {
      return NewOrder(_setIndex, true, i);
    } else if (i == 3) {
      return PendingScreen();
    } else if (i == 4) {
      return Profile();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          drawer: DrawerScreen(),
          bottomNavigationBar: i<5 ? NavBar(_setIndex): Container(),
          backgroundColor: Color(0xffF5F5F5),
          body: Column(
            children: [
              i==5? Header(i, false): Header(i, true),
              Expanded(child: _changeActivity(i)),
            ],
          ),
        ),
    );
  }
}
