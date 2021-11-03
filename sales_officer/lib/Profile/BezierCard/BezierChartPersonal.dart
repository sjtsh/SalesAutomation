import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Database.dart';

class BezierChartPersonal extends StatefulWidget {
  @override
  _BezierChartPersonalState createState() => _BezierChartPersonalState();
}

class _BezierChartPersonalState extends State<BezierChartPersonal> {
  List salesTaken = [0,0,0,0,0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      salesTaken
          .asMap()
          .entries
          .forEach((e) {
        for (int i = 0; i < sales[e.key]; i++) {
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                salesTaken[e.key]++;
              });
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(enabled: true),
        lineBarsData: [
          LineChartBarData(
            spots: sales
                .asMap()
                .entries
                .map(
                    (content) => FlSpot(content.key + 1.0, content.value + 0.0))
                .toList(),
            isCurved: false,
            colors: [
              Color(0xff5A6FF0),
              Color(0xffC31FE6),
            ],
            belowBarData: BarAreaData(
              show: false,
              colors: [
                Color(0xff5A6FF0),
                Color(0xffC31FE6),
              ],
            ),
            dotData: FlDotData(
              show: false,
            ),
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: false,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            interval: 10000,
          ),
        ),
        axisTitleData: FlAxisTitleData(
            leftTitle: AxisTitle(showTitle: false),
            bottomTitle: AxisTitle(
              showTitle: false,
            )),
        gridData: FlGridData(
          show: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
      ),
      // swapAnimationDuration: Duration(milliseconds: 500), // Optional
      // swapAnimationCurve: Curves.easeIn,
    );
  }
}
