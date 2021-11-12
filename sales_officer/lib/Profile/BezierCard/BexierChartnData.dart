import 'package:flutter/material.dart';

import '../../Database.dart';
import 'BezierChartPersonal.dart';
import 'BezierData.dart';

class BezierChartnData extends StatelessWidget {
  final e;
  final _expandableController;
  final Function changeExpanded;
  final bool toggleValue;

  BezierChartnData(this.e, this._expandableController, this.changeExpanded, this.toggleValue);


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          margin:
          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          height: 100,
          child: BezierChartPersonal(
              e,
              e ? weeklySalesLocal : monthlySalesLocal,
              toggleValue),
        ),
        BezierData(_expandableController, changeExpanded, e,
            toggleValue),
      ],
    );
  }
}
