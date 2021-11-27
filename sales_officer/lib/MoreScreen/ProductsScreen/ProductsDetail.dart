import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timelines/timelines.dart';

import '../../Header.dart';

class ProductsDetail extends StatelessWidget {
  final Function refresh;

  ProductsDetail(this.refresh);

  @override
  Widget build(BuildContext context) {
    List points = [
      "High in diatary fiber.",
      "Good source if protein and iron.",
      "Helps reduce cholesterol.",
      "Zerocholesterol.",
      "No added sugar, salt and preservatives."
    ];
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      child: Image.asset(
                        "products/Rectangle 135.png",
                        fit: BoxFit.fill,
                      ),
                      // color: Colors.blue,
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Hilife Rolled Oats",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.8)),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -1,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      // Positioned(child: Text("data"))
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 0.2,
                            sigmaY: 0.2,
                          ),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withOpacity(0.9),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Positioned(child: Text("data"))
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rs. 132",
                        style: TextStyle(
                            color: Color(0xffFC5E05),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Description:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Oats are among the healthiest grains on earth. The gluten free whole grain is a great source of important minerals,fiber and antioxidants to get you rolling ( and also lose a few pounds while you're at it )",
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Ingredients:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Table(
                        // defaultColumnWidth: FixedColumnWidth(120.0),
                        border: TableBorder.all(color: Colors.black, width: 1),
                        children: [
                          TableRow(children: [
                            Column(children: [
                              Text(
                                'Wheat (2.5%)',
                              )
                            ]),
                            Column(children: [
                              Text(
                                'Wheat (2.5%)',
                              )
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Text(
                                'Wheat (2.5%)',
                              )
                            ]),
                            Column(children: [
                              Text(
                                'Wheat (2.5%)',
                              )
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Text(
                                'Wheat (2.5%)',
                              )
                            ]),
                            Column(children: [
                              Text(
                                'Wheat (2.5%)',
                              )
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Text(
                                'Wheat (2.5%)',
                              )
                            ]),
                            Column(children: [
                              Text(
                                'Wheat (2.5%)',
                              )
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              Text(
                                'Wheat (2.5%)',
                              )
                            ]),
                            Column(children: [
                              Text(
                                'Wheat (2.5%)',
                              )
                            ]),
                          ]),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Key Points:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: points
                            .map(
                              (e) => Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text((points.indexOf(e) + 1).toString() +
                                          "."),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(e),
                                    ],
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Safety Measures:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: points
                            .map(
                              (e) => Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text((points.indexOf(e) + 1).toString() +
                                      "."),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(e),
                                ],
                              ),
                            ],
                          ),
                        )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
