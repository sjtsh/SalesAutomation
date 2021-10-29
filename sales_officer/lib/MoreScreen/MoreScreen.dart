import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';
import 'package:sales_officer/NavBar/NavBar.dart';
import 'package:sales_officer/MoreScreen/Settings/Settings.dart';
import 'package:sales_officer/TourPlanScreen/TourPlanScreen.dart';

import 'FAQScreen/FAQScreen.dart';

class MoreScreen extends StatelessWidget {
  final Function refresh;

  MoreScreen(this.refresh);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2))
              ],
            ),
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return TourPlanScreen(refresh);
                  }));
                },
                child: Container(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.tour,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(child: Text("Create Tour Plan")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2))
              ],
            ),
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Settings(refresh);
                })),
                child: Container(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(child: Text("Settings")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2))
              ],
            ),
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: Colors.deepPurple,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Text(
                          "My Performance",
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2))
              ],
            ),
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return LogInScreen();
                  }));
                },
                child: Container(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.track_changes,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Text(
                          "Change Beat",
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2))
              ],
            ),
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return FAQScreen(refresh);
                  }));
                },
                child: Container(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.question_answer,
                          color: Colors.pink,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Text(
                          "FAQ",
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2))
              ],
            ),
            child: Container(
              color: Colors.white,
              child: Material(
                color: Colors.red.withOpacity(0.8),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.trending_down,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              child: Text(
                            "End Day",
                            style: TextStyle(color: Colors.white),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
