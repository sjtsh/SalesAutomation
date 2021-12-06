import 'package:flutter/material.dart';

import '../Database.dart';

class StatScreen extends StatefulWidget {
  final bool isMTD;
  final bool toggleValue;

  StatScreen(this.isMTD, this.toggleValue);

  @override
  _StatScreenState createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  // String dropdownValue = 'MTD';
  double totalMonthlyValue = 0;
  double totalYearlyValue = 0;
  int monthlySKU = 0;
  int yearlySKU = 0;
  int monthlySKUTarget = 20;
  int yearlySKUTarget = 50;
  double monthlyValueTarget = 10000000;
  double yearlyValueTarget = 120000000;
  bool animated = false;

  @override
  void initState() {
    // TODO: implement initState

    products.entries.forEach((element) {
      totalMonthlyValue += element.value[0];
      if (element.value[0] != 0) {
        monthlySKU++;
      }
    });
    products.entries.forEach((element) {
      totalYearlyValue += element.value[1];
      if (element.value[1] != 0) {
        yearlySKU++;
      }
    });
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        animated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 3,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Progress',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(widget.isMTD ? "MTD" : "YTD"),
                  // Container(
                  //   width: 70,
                  //   child: DropdownButton<String>(
                  //     icon: Icon(Icons.keyboard_arrow_down_rounded),
                  //     isExpanded: true,
                  //     value: dropdownValue,
                  //     underline: Container(),
                  //     iconSize: 20,
                  //     iconEnabledColor: Colors.black,
                  //     elevation: 0,
                  //     style: const TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 14,
                  //     ),
                  //     onChanged: (newValue) {
                  //       _setNewProducts(newValue!);
                  //     },
                  //     items: <String>[
                  //       'MTD',
                  //       'YTD',
                  //     ].map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Align(
                  //           alignment: Alignment.center,
                  //           child: Text(
                  //             value,
                  //           ),
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    widget.isMTD
                        ? totalMonthlyValue.toString()
                        : totalYearlyValue.toString(),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 12),
                  ),
                  Expanded(child: Container()),
                  Text(
                    widget.isMTD
                        ? monthlyValueTarget.toString()
                        : yearlyValueTarget.toString(),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 12),
                  ),
                ],
              ),
              Builder(builder: (context) {
                double totalWidth = MediaQuery.of(context).size.width;
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                      ),
                      width: totalWidth,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xffe8e8e8),
                      ),
                    ),
                    AnimatedContainer(
                      margin: EdgeInsets.only(
                        top: 5,
                      ),
                      width: animated
                          ? widget.isMTD
                              ? totalWidth *
                                  (totalMonthlyValue / monthlyValueTarget)
                              : totalWidth *
                                  (totalYearlyValue / yearlyValueTarget)
                          : 0,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          colors: widget.toggleValue
                              ? [
                                  Color(0xff129C8D),
                                  Color(0xff34E77E),
                                ]
                              : [
                                  Color(0xffEB1469),
                                  Color(0xffFD5B11),
                                ],
                        ),
                      ),
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOut,
                    ),
                  ],
                );
              }),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    widget.isMTD ? monthlySKU.toString() : yearlySKU.toString(),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 12),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "${widget.isMTD ? monthlySKUTarget : yearlySKUTarget} SKU",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 12),
                  ),
                ],
              ),
              Builder(builder: (context) {
                double totalWidth = MediaQuery.of(context).size.width;
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                      ),
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xffe8e8e8),
                      ),
                    ),
                    AnimatedContainer(
                      margin: EdgeInsets.only(
                        top: 5,
                      ),
                      width: animated
                          ? widget.isMTD
                              ? totalWidth * (monthlySKU / monthlySKUTarget)
                              : totalWidth * (yearlySKU / yearlySKUTarget)
                          : 0,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            colors: widget.toggleValue
                                ? [
                                    Color(0xff129C8D),
                                    Color(0xff34E77E),
                                  ]
                                : [
                                    Color(0xffEB1469),
                                    Color(0xffFD5B11),
                                  ]),
                      ),
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOut,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
