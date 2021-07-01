import 'package:flutter/material.dart';
import 'package:sales_officer/Profile/Achievements/Achievements.dart';
import 'package:sales_officer/Profile/Header/Header.dart';

import 'BezierCard/BezierCard.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 10,),
        Header(),
        BezierCard(),
        Achievements(),
      ],
    );
  }
}
