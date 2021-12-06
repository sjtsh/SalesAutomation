import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sales_officer/MoreScreen/ActivitiesScreen/ActivitiesScreen.dart';
import 'package:sales_officer/Profile/Achievements/Achievements.dart';
import 'package:sales_officer/Profile/Header/Header.dart';
import 'package:sales_officer/Profile/Header/Online.dart';
import 'package:sales_officer/Profile/SliderPersonal.dart';
import 'package:sales_officer/Profile/StatScreen.dart';
import 'package:shimmer/shimmer.dart';
import '../Database.dart';
import 'BezierCard/BezierCard.dart';

class Profile extends StatefulWidget {
  final Function refresh;

  Profile(this.refresh);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  refreshChart() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Header(),
        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        // child: Container(
        //     height: 90,
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(60),
        //       color: Colors.grey,
        //     ),
        //   ),
        // ),
        Row(
          children: [
            SizedBox(width: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_){
                  return ActivitiesScreen(widget.refresh);
                }));
              },
                child: Online()),
            Expanded(child: SliderPersonal(refreshChart,widget.refresh)),
          ],
        ),
        BezierCard(isRetailing?? false, widget.refresh),
        Achievements(),
      ],
    );
  }
}
