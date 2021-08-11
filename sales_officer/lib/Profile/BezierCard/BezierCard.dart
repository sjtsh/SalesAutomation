import 'package:flutter/material.dart';
import 'package:sales_officer/Profile/BezierCard/BezierChartPersonal.dart';

import 'BezierData.dart';
import 'BezierHeading.dart';

class BezierCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
              offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 6,),
          BezierHeading(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            height: 100,
            child: BezierChartPersonal(),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: BezierData(),
          ),
        ],
      ),
    );
  }
}