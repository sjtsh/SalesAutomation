import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../Database.dart';

class BezierChartPersonal extends StatefulWidget {
  final bool isMTD;
  final List<double> sales;
  final bool toggleValue;

  BezierChartPersonal(this.isMTD, this.sales, this.toggleValue);

  @override
  _BezierChartPersonalState createState() => _BezierChartPersonalState();
}

class _BezierChartPersonalState extends State<BezierChartPersonal> {
  List<double> normalizedSales = [];

  @override
  void initState() {
    // TODO: implement initState
    // normalizedSales = widget.sales;
    normalizedSales = List.generate(widget.sales.length, (index) => 0);
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      int a = 0;
      widget.sales.forEach((element) {
        setState(() {
          normalizedSales[a] = (element / 1000000);
        });
        a++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        showingTooltipIndicators: [],
        lineTouchData: LineTouchData(enabled: true),
        lineBarsData: [
          widget.toggleValue ? LineChartBarData(
      showingIndicators: [],
        preventCurveOverShooting: true,
        preventCurveOvershootingThreshold: 0,
        spots: normalizedSales
            .asMap()
            .entries
            .map((content) =>
            FlSpot(content.key + 1.0, content.value + 0.0))
            .toList(),
        isCurved: true,
        colors: [
          Color(0xff129C8D),
          Color(0xff34E77E),
        ],
        belowBarData: BarAreaData(
          show: true,
          colors: [
            Color(0xff129C8D),
            Color(0xff34E77E),
          ],
        ),
        dotData: FlDotData(
          show: false,
        ),
      ) : LineChartBarData(
      showingIndicators: [],
      preventCurveOverShooting: true,
      preventCurveOvershootingThreshold: 0,
      spots: normalizedSales
          .asMap()
          .entries
          .map(
              (content) => FlSpot(content.key + 1.0, content.value + 0.0))
          .toList(),
      isCurved: true,
      colors: [
        Color(0xffEB1469),
        Color(0xffFD5B11),
      ],
      belowBarData: BarAreaData(
        show: true,
        colors: [
          Color(0xffEB1469),
          Color(0xffFD5B11),
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
              interval:
                  (normalizedSales.reduce(max) - normalizedSales.reduce(min)) /
                              normalizedSales.length ==
                          0
                      ? 1
                      : (normalizedSales.reduce(max) -
                              normalizedSales.reduce(min)) /
                          normalizedSales.length,
              getTextStyles: (context, double a) {
                return TextStyle(fontSize: 8);
              }),
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
      swapAnimationDuration: Duration(milliseconds: 500), // Optional
      swapAnimationCurve: Curves.easeInOut,
    );
  }
}
