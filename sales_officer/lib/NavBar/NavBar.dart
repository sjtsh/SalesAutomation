import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final boxShadow = [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0,2))];
  static int _currentIndex = 0;
  final Function _setIndex;

  NavBar(this._setIndex);

  static void onItemTapped(int i){
    _currentIndex = i;
  }

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: Container(
        decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: Offset(0,-2))]),
          child: CustomNavigationBar(

              blurEffect: true,
              iconSize: 25,
              currentIndex: NavBar._currentIndex,
              selectedColor: Colors.black,
              backgroundColor: Colors.white,
              opacity: 1,
              onTap: (int i) {
                print("clicked");
                print(i);
                NavBar.onItemTapped(i);
                widget._setIndex(i);
              },
              items: [
                CustomNavigationBarItem(
                  icon: Icon(Icons.image,),
                  title: Text("New Order", style: TextStyle(color: Colors.black, fontSize: 12),),
                ),
                CustomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  title: Text("Pending Orders", style: TextStyle(color: Colors.black, fontSize: 12),),
                ),
                CustomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  title: Text("Update Stocks", style: TextStyle(color: Colors.black, fontSize: 12),),
                ),
                CustomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  title: Text("Distributor", style: TextStyle(color: Colors.black, fontSize: 12),),
                ),
              ],
          ),
        ));
  }
}
