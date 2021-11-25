import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';
import 'package:sales_officer/MoreScreen/TimelineScreen/TimelineScreen.dart';
import 'package:sales_officer/MoreScreen/ViewStockScreen/ViewStock.dart';
import 'package:sales_officer/NavBar/NavBar.dart';
import 'package:sales_officer/MoreScreen/Settings/Settings.dart';
import 'package:sales_officer/TourPlanScreen/TourPlanScreen.dart';

import 'ActivitiesScreen/ActivitiesScreen.dart';
import 'GoogleMap.dart';
import 'FAQScreen/FAQScreen.dart';

class MoreScreen extends StatelessWidget {
  final Function refresh;
  final int index;
  final Function _setIndex;

  MoreScreen(this.refresh, this.index, this._setIndex);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: [
        [Icons.tour, Colors.green, "Tour Plan", TourPlanScreen(refresh)],
        [Icons.settings, Colors.blueGrey, "Settings", Settings(refresh)],
        [Icons.trending_up, Colors.deepPurple, "Performance", Container()],
        [Icons.timeline, Colors.blueAccent, "Timeline", TimelineScreen()],
        [Icons.question_answer, Colors.pink, "FAQ", FAQScreen(refresh)],
        [Icons.trending_down, Colors.red, "View Stock", ViewStock(refresh)],
        [Icons.message, Colors.blue, "Objection", FAQScreen(refresh)],
        [
          Icons.work_outline_sharp,
          Colors.pinkAccent,
          "Tasks",
          ActivitiesScreen(refresh)
        ],
      ]
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
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
                      if (e[2] == "Performance") {

                        _setIndex(0);
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return e[3] as Widget;
                        }));
                      }
                    },
                    child: Container(
                      height: 70,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              e[0] as IconData,
                              color: e[1] as Color,
                              size: 40,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              e[2].toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
