import 'package:flutter/material.dart';

import '../../Database.dart';
import '../../Header.dart';
import 'BezierChartPersonal.dart';

class SeeAllSalesScreen extends StatefulWidget {
  final bool isMTD;
  final Function refresh;
  final bool toggleValue;
  final List listOfProducts;

  SeeAllSalesScreen(
      this.isMTD, this.refresh, this.toggleValue, this.listOfProducts);

  @override
  _SeeAllSalesScreenState createState() => _SeeAllSalesScreenState();
}

class _SeeAllSalesScreenState extends State<SeeAllSalesScreen> {
  int pageNumber = 0;
  PageController _pageController = PageController();
  bool setArrow = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                  reverse: !widget.isMTD,
                  onPageChanged: (int i) {
                    setState(() {
                      pageNumber = i;
                      setArrow = !setArrow;
                    });
                  },
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: [true, false]
                      .map(
                        (e) => Column(
                          children: [
                            Header(
                                e == widget.isMTD ? 13 : 14, false, widget.refresh),
                            Container(
                              height: 150,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 3,
                                      offset: Offset(0, 2))
                                ],
                              ),
                              child: Hero(
                                tag: "chart",
                                child: BezierChartPersonal(
                                    e == widget.isMTD
                                        ? weeklySalesLocal
                                        : monthlySalesLocal,
                                    widget.toggleValue),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                children: [
                                  Column(
                                    children: [
                                      Builder(builder: (context) {
                                        if (e == widget.isMTD) {
                                          return Container(
                                            decoration: BoxDecoration(),
                                            child: Column(
                                              children: widget.listOfProducts
                                                  .where((element) =>
                                                      !(element[1][0] == 0))
                                                  .toList()
                                                  .map((item) => Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Colors.black
                                                                  .withOpacity(0.1),
                                                            ),
                                                          ),
                                                        ),
                                                        child: Container(
                                                          height: 50,
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  left: 12,
                                                                  right: 12),
                                                          child: Row(
                                                            children: [
                                                              Text((widget.listOfProducts
                                                                              .where((element) =>
                                                                                  element[1][0] !=
                                                                                  0)
                                                                              .toList()
                                                                              .indexOf(
                                                                                  item) +
                                                                          1)
                                                                      .toString() +
                                                                  "."),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: Text(allSKULocal
                                                                    .firstWhere(
                                                                        (element) =>
                                                                            item[0] ==
                                                                            element
                                                                                .SKUID)
                                                                    .SKUName),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                "Rs. ${e == widget.isMTD ? item[1][0] : item[1][1]}",
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          );
                                        } else {
                                          widget.listOfProducts.sort(
                                              (a, b) => b[1][0].compareTo(a[1][0]));
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                        Colors.black.withOpacity(0.1),
                                                    blurRadius: 3,
                                                    offset: Offset(0, 2))
                                              ],
                                            ),
                                            child: Column(
                                              children: widget.listOfProducts
                                                  .where((element) =>
                                                      !(element[1][1] == 0))
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
                                                          padding:
                                                              const EdgeInsets.only(
                                                            right: 12,
                                                            left: 12,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Text((widget.listOfProducts
                                                                              .indexOf(
                                                                                  item) +
                                                                          1)
                                                                      .toString() +
                                                                  "."),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: Text(allSKULocal
                                                                    .firstWhere(
                                                                        (element) =>
                                                                            item[0] ==
                                                                            element
                                                                                .SKUID)
                                                                    .SKUName),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                "Rs. ${e == widget.isMTD ? item[1][0] : item[1][1]}",
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          );
                                        }
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList()),
            ),
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 50,
                      decoration: BoxDecoration(
                        color: widget.toggleValue
                            ? Color(0xff129C8D)
                            : Color(0xffFD5B11),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (widget.isMTD) {
                            _pageController.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          } else {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          }
                        },
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: setArrow == widget.isMTD ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (widget.isMTD) {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          } else {
                            _pageController.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          }

                        },
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: setArrow == widget.isMTD ? Colors.grey : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12,),
          ],
        ),
      ),
    );
  }
}
