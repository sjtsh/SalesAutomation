import 'package:flutter/material.dart';
import 'package:sales_officer/HomeScreen.dart';

class SelectBeat extends StatefulWidget {
  @override
  _SelectBeatState createState() => _SelectBeatState();
}

class _SelectBeatState extends State<SelectBeat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 130,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "John Doe",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Sales Officer",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                "Please select your today's beat",
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 60 * 6,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, 3),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: ListView(
                    children: [
                      "Dhumbarahi- Sukedhara",
                      "Chabahil- Mitrapark",
                      "Gopikrishna- Pahelo Pool",
                      "Pahelo Pool- Rato Poo",
                      "Gopikrishna- Pahelo Pool",
                      "Kalo Pool- Rato Pool",
                      "Kalo Pool- Rato Pool",
                      "Kalo Pool- Rato Pool",
                      "Kalo Pool- Rato Pool",
                    ]
                        .asMap()
                        .entries
                        .map((e) => GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                              },
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      e.value,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:Colors.black),
                                    ),
                                    Expanded(child: Container()),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
