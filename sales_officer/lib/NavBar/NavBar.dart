import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBar extends StatefulWidget {
  final boxShadow = [
    BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 3,
        offset: Offset(0, 2))
  ];
  static int currentIndex = 0;
  final Function _setIndex;

  NavBar(this._setIndex);

  static void onItemTapped(int i) {
    currentIndex = i;
  }

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: Offset(0, -2))
      ]),
      child: CustomNavigationBar(
        strokeColor: Colors.blue.withOpacity(0.5),
        iconSize: 25,
        currentIndex: NavBar.currentIndex,
        selectedColor: Colors.black,
        unSelectedColor: Colors.black.withOpacity(0.5),
        backgroundColor: Colors.white,
        opacity: 1,
        onTap: (int i) {
          NavBar.onItemTapped(i);
          widget._setIndex(i);
        },
        items: [
          CustomNavigationBarItem(
            icon: SvgPicture.asset(
              "icons/dashboard.svg",
              color: NavBar.currentIndex == 0
                  ? Colors.blue
                  : Colors.black.withOpacity(0.5),
            ),
            title: Text(
              "Dashboard",
              style: TextStyle(
                  color: NavBar.currentIndex == 0
                      ? Colors.blue
                      : Colors.black.withOpacity(0.5),
                  fontSize: 10),
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: NavBar.currentIndex == 1
                  ? Colors.blue
                  : Colors.black.withOpacity(0.5),
            ),
            title: Text(
              "New",
              style: TextStyle(
                  color: NavBar.currentIndex == 1
                      ? Colors.blue
                      : Colors.black.withOpacity(0.5),
                  fontSize: 10),
            ),
          ),
          CustomNavigationBarItem(
            icon: SvgPicture.asset(
              "icons/pendingorder.svg",
              color: NavBar.currentIndex == 2
                  ? Colors.blue
                  : Colors.black.withOpacity(0.5),
            ),
            title: Text(
              "Pending",
              style: TextStyle(
                  color: NavBar.currentIndex == 2
                      ? Colors.blue
                      : Colors.black.withOpacity(0.5),
                  fontSize: 10),
            ),
          ),

          CustomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              color: NavBar.currentIndex == 3
                  ? Colors.blue
                  : Colors.black.withOpacity(0.5),
            ),
            title: Text(
              "More",
              style: TextStyle(
                  color: NavBar.currentIndex == 3
                      ? Colors.blue
                      : Colors.black.withOpacity(0.5),
                  fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
