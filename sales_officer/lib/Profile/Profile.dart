import 'package:flutter/material.dart';
import 'package:sales_officer/Profile/Achievements/Achievements.dart';
import 'package:sales_officer/Profile/Header/Header.dart';
import 'package:sales_officer/Profile/Header/Online.dart';
import 'BezierCard/BezierCard.dart';

class Profile extends StatefulWidget {
  final Function refresh;

  Profile(this.refresh);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool condition = false;
  double sliderValue = 0;
  bool toggleValue = false;

  slide(bool newCondition) {
    setState(() {
      condition = newCondition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 10,
        ),
        Header(),
        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Container(
        //     height: 90,
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(60),
        //       color: Colors.grey,
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            height: 75,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: toggleValue
                  ? LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color(0xff34E77E),
                        Color(0xff129C8D),
                      ],
                    )
                  : LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color(0xffEB1469),
                        Color(0xffFD5B11),
                      ],
                    ),
              // color: toggleValue
              //     ? Colors.green.withOpacity(0.1)
              //     : Colors.red.withOpacity(0.1),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.easeIn,
                  left: toggleValue ? 30 : 0,
                  right: toggleValue ? 0 : 300,
                  child: InkWell(
                    onTap: toggleButton,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 1000),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: toggleValue
                          ? IntrinsicHeight(
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "STATUS",
                                        style: TextStyle(
                                            fontFamily: "lato",
                                            fontSize: 12,
                                            color:Colors.white.withOpacity(0.5),),
                                      ),
                                      Text(
                                        "Retailing",
                                        style: TextStyle(
                                            fontFamily: "lato",
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "TOTAL TIME",
                                        style: TextStyle(
                                            fontFamily: "lato",
                                            fontSize: 12,
                                            color: Colors.white.withOpacity(0.5),),
                                      ),
                                      Text(
                                        "2h:04m:10s",
                                        style: TextStyle(
                                            fontFamily: "lato",
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Online(),
                                ],
                              ),
                            )
                          : Online(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        BezierCard(),
        Achievements(),
      ],
    );
  }

  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}
