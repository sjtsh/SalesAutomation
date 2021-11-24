import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  MoreScreen(this.refresh,this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),

      child: ListView(
        children: [
          SizedBox(height: 12,),
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
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return TimelineScreen();
                  }));
                },
                child: Container(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timeline,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Text(
                              "Timeline",
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 12,
          // ),
          // Container(
          //   clipBehavior: Clip.hardEdge,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //     boxShadow: [
          //       BoxShadow(
          //           color: Colors.black.withOpacity(0.1),
          //           blurRadius: 3,
          //           offset: Offset(0, 2))
          //     ],
          //   ),
          //   child: Material(
          //     color: Colors.white,
          //     child: InkWell(
          //       onTap: () {
          //         Navigator.push(context, MaterialPageRoute(builder: (_) {
          //           return LogInScreen();
          //         }));
          //       },
          //       child: Container(
          //         height: 70,
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //           child: Row(
          //             children: [
          //               Icon(
          //                 Icons.track_changes,
          //                 color: Colors.blue,
          //               ),
          //               SizedBox(
          //                 width: 12,
          //               ),
          //               Expanded(
          //                   child: Text(
          //                 "Change Beat",
          //               )),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
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
          ),SizedBox(
            height: 12,
          ),
          // Container(
          //   clipBehavior: Clip.hardEdge,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //     boxShadow: [
          //       BoxShadow(
          //           color: Colors.black.withOpacity(0.1),
          //           blurRadius: 3,
          //           offset: Offset(0, 2))
          //     ],
          //   ),
          //   child: Material(
          //     color: Colors.white,
          //     child: InkWell(
          //       onTap: () {
          //         Navigator.push(context, MaterialPageRoute(builder: (_){
          //           return GoogleMapPersonal();
          //         }));
          //       },
          //       child: Container(
          //         height: 70,
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //           child: Row(
          //             children: [
          //               Icon(Icons.map,
          //                 color: Colors.green,
          //               ),
          //               SizedBox(
          //                 width: 12,
          //               ),
          //               Expanded(
          //                   child: Text(
          //                     "MAP",
          //                   )),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 12,
          // ),
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
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                   return ViewStock(refresh);
                  }));
                },
                child: Container(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.trending_down,color: Colors.red,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Text(
                          "View Stock",
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12,),
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
                },
                child: Container(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.message,color: Colors.blue,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Text(
                              "Complain Box",
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12,),
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
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return ActivitiesScreen(refresh);
                  }));
                },
                child: Container(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.work_outline_sharp,color: Colors.pinkAccent,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Text(
                              "Activities",
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12,)
        ],
      ),

    );
  }
}
