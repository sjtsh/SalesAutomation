import 'package:flutter/material.dart';

import '../../Database.dart';
import '../../Header.dart';
import 'BezierChartPersonal.dart';

class SeeAllSalesScreen extends StatelessWidget {
  final bool isMTD;
  final Function refresh;
  final bool toggleValue;
  final List listOfProducts;

  SeeAllSalesScreen(this.isMTD, this.refresh, this.toggleValue, this.listOfProducts);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(isMTD ? 13 : 14, false, refresh),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 12,),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16),
                    height: 150,
                    child: BezierChartPersonal(
                        isMTD,
                        isMTD
                            ? weeklySalesLocal
                            : monthlySalesLocal,
                        toggleValue),
                  ),
                  Builder(builder: (context) {
                    if (isMTD) {
                      return Column(
                        children: listOfProducts
                            .where((element) => !(element[1][0] == 0))
                            .toList()
                            .map((item) => Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black
                                    .withOpacity(0.1),
                              ),
                            ),
                          ),
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                                left: 12,right: 12),
                            child: Row(
                              children: [
                                Text((listOfProducts
                                    .indexOf(item) +
                                    1)
                                    .toString() +
                                    "."),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(allSKULocal
                                      .firstWhere((element) =>
                                  item[0] ==
                                      element.SKUID)
                                      .SKUName),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  "Rs. ${isMTD ? item[1][0] : item[1][1]}",
                                ),
                              ],
                            ),
                          ),
                        ))
                            .toList(),
                      );
                    } else {
                      listOfProducts
                          .sort((a, b) => b[1][0].compareTo(a[1][0]));
                      return Column(
                        children: listOfProducts
                            .where((element) => !(element[1][1] == 0))
                            .toList()
                            .map((item) => Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black
                                    .withOpacity(0.1),
                              ),
                            ),
                          ),
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              right: 12,
                              left: 12,),
                            child: Row(
                              children: [
                                Text((listOfProducts
                                    .indexOf(item) +
                                    1)
                                    .toString() +
                                    "."),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(allSKULocal
                                      .firstWhere((element) =>
                                  item[0] ==
                                      element.SKUID)
                                      .SKUName),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Rs. ${isMTD ? item[1][0] : item[1][1]}",
                                ),
                              ],
                            ),
                          ),
                        ))
                            .toList(),
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
