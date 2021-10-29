import 'package:flutter/material.dart';
import 'package:sales_officer/Header.dart';
import 'package:sales_officer/NavBar/NavBar.dart';
import 'package:sales_officer/DistributorList/NewOrder.dart';
import 'package:sales_officer/PendingScreen/PendingScreen.dart';
import 'package:sales_officer/Profile/Profile.dart';

import 'MoreScreen/MoreScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  _setIndex(int i) {
    setState(() {
      this.currentIndex = i;
    });
  }

  Future<bool> _onBackPressed() async {
    _setIndex(2);
    return false;
  }

  Widget _changeActivity(int i) {
    if (i == 0) {
      return Profile(refresh);
    } else if (i == 1) {
      return NewOrder(i, refresh);
    } else if (i == 2) {
      return PendingScreen(refresh);
    } else if (i == 3) {
      return MoreScreen(refresh);
    } else {
      return Container();
    }
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: currentIndex < 5 ? NavBar(_setIndex, currentIndex) : Container(),
          backgroundColor: Color(0xffF5F5F5),
          body: Column(
            children: [
              currentIndex == 5 ? Header(currentIndex, false, refresh) : Header(currentIndex, true, refresh),
              Expanded(child: _changeActivity(currentIndex)),
            ],
          ),
        ),
      ),
    );
  }
}
