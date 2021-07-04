import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Database.dart';

class BezierChartPersonal extends StatefulWidget {
  // List sales = [30233, 20003, 19000, 10003, 9003];

  @override
  _BezierChartPersonalState createState() => _BezierChartPersonalState();
}

class _BezierChartPersonalState extends State<BezierChartPersonal> {

  List salesTaken = [0, 0, 0, 0, 0];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      salesTaken = sales;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(enabled: true),
        lineBarsData: [
          LineChartBarData(
            spots: salesTaken
                .map((content) =>
                    FlSpot(sales.indexOf(content) + 1.0, content + 0.0))
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
      swapAnimationDuration: Duration(milliseconds: 2000), // Optional
      swapAnimationCurve: Curves.easeIn,
    );
  }

}
