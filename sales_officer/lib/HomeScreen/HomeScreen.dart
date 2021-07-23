import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_officer/Construction/Construction.dart';
import 'package:sales_officer/DistributorInfo/DistributorInfo.dart';
import 'package:sales_officer/DrawerScreen/DrawerScreen.dart';
import 'package:sales_officer/Header/Header.dart';
import 'package:sales_officer/Header/HeaderProductVariationPage.dart';
import 'package:sales_officer/NavBar/ConfirmOrder.dart';
import 'package:sales_officer/NavBar/NavBar.dart';
import 'package:sales_officer/NewOrder/NewOrder.dart';
import 'package:sales_officer/NewOrder/ProductsScreen/ProductsScreen.dart';
import 'package:sales_officer/Pages/Page1.dart';
import 'package:sales_officer/Pages/Page2.dart';
import 'package:sales_officer/Pages/Page3.dart';
import 'package:sales_officer/Pages/Page4.dart';
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
      return NewOrder(_setIndex, true);
    } else if (i == 1) {
      return PendingScreen();
    } else if (i == 2) {
      return Profile();
    } else if (i == 3) {
      return NewOrder(_setIndex, false);
    } else if (i == 4) {
      return NewOrder(_setIndex, true);
    } else if (i == 5) {
      return ProductsScreen(_setIndex);
    } else if (i == 6) {
      return DistributorInfo(_setIndex);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: _onBackPressed,
        child: SafeArea(
          child: Scaffold(
            drawer: DrawerScreen(),
            floatingActionButton: i > 4
                ? null
                : FloatingActionButton(
                    onPressed: () {
                      print(i.toString() + " into " + "4");
                      _setIndex(4);
                      NavBar.onItemTapped(4);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            bottomNavigationBar: i<5 ? NavBar(_setIndex): null,
            backgroundColor: Color(0xffF5F5F5),
            body: Column(
              children: [
                i==5? HeaderProductVariationPage(i): Header(i),
                Expanded(child: _changeActivity(i)),
              ],
            ),
          ),
        ),
    );
  }
}
